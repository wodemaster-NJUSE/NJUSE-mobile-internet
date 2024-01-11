import { ChatContact, FriendMoment } from '../../viewmodel/MsgBase';
import picker from '@ohos.file.picker';
import common from '@ohos.app.ability.common';
import fs from '@ohos.file.fs';
import request from '@ohos.request';
import { MediaBean, MediaHelper } from './MediaHelper';
import { RequestMethod, RequestOptions } from '../../utils/http/RequestOptions';
import { HttpManager } from '../../utils/http/HttpManager';
import { ResponseResult } from '../../utils/http/HttpCore';
import { CommonConstants } from '../../common/constants/CommonConstants';
import router from '@ohos.router';

// 获取应用文件路径
let context = getContext(this) as common.UIAbilityContext;
let cacheDir = context.cacheDir;

// 上传任务配置项
// 获取应用文件路径

let uploadConfig = {
  url: 'http://172.29.4.148:8080/',
  header: { key1: 'Content-Type', key2: 'multipart/form-data' },
  method: 'POST',
  files: [
    { filename: 'test.jpg', name: 'test', uri: 'internal://cache/test.jpg', type: 'jpg' }
  ],
  data: [
    { name: 'fileId', value: 'FP000008' }
  ]
}
@Entry
@Component
export struct AddMomentsPage {
  // 添加新动态，点击发表的时候要更新动态列表
  uid: string = globalThis.UID; // 通过uid来向后端获取对应的数据
  private keyboardStr : string = ''; // 刷新输入
  private myChatContact: ChatContact = new ChatContact(this.uid, '','');
  // userId: string
  // userName: string | Resource
  // userImage: string | Resource
  private imageList : Array<string> = new Array<string>();
  private time : Date = new Date();
  private newMoment: FriendMoment = new FriendMoment(this.uid, this.myChatContact, this.keyboardStr, this.time.toString(),this.imageList, '', '');
  // id: string
  // user: ChatContact
  // text: string
  // time: string = ''
  // imageList: Array<string> = new Array<string>()
  // media: string = '' // media为需要获取的视频url
  // mediaPreview: string = '' //mediaPreview为需要获取的视频预览图url
  @State pictures: Array<string> = [];
  private mediaHelper: MediaHelper = new MediaHelper(getContext());

  async aboutToAppear(){
    // 加载前对myChatContact进行填充，向后端获取数据
    console.info('addMomentsPage get uid'+ this.uid)
  }
  @State message: string = ''
  @State imgSrc: string = ''

  async selectImage() {
    try {
      let PhotoSelectOptions = new picker.PhotoSelectOptions();
      PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      PhotoSelectOptions.maxSelectNumber = 1;
      let photoPicker = new picker.PhotoViewPicker();
      photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult) => {
        console.info('xx PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult));
        // 从图库选择图片后，返回图片uri
        let uri = PhotoSelectResult.photoUris[0];
        console.info('xx uri:' + uri)
        this.imgSrc = uri
        // 读取上面返回uri
        let file = fs.openSync(uri, fs.OpenMode.CREATE);
        // 复制文件到缓存目录下
        fs.copyFileSync(file.fd, cacheDir + '/test.jpg')
        // 上传文件到服务器上
        this.uploadImage()
      }).catch((err) => {
        console.error('xx PhotoViewPicker.select failed with err: ' + err);
      });
    } catch (err) {
      console.error('xx PhotoViewPicker failed with err: ' + err);
    }
  }

  uploadImage() {
    // 将本地应用文件上传至网络服务器
    try {
      request.uploadFile(context, uploadConfig)
        .then((uploadTask) => {
          uploadTask.on('complete', (taskStates) => {
            for (let i = 0; i < taskStates.length; i++) {
              console.info(`xx upload complete taskState: ${JSON.stringify(taskStates[i])}`);
              this.message = JSON.stringify(taskStates[i])
            }
          });
        })
        .catch((err) => {
          console.error(`xx Invoke uploadFile failed, code is ${err.code}, message is ${err.message}`);
          this.message = err.message
        })
    } catch (err) {
      console.error(`xx Invoke uploadFile failed, code is ${err.code}, message is ${err.message}`);
      this.message = err.message
    }
  }

  build() {

    Column() {
      this.TopBar()
      Column({space: 30}) {
        Button('打开图库')
          .width('80%').height('40')
          .onClick(() => {
            this.selectImage()
          })
        Image(this.imgSrc)
          .width('50%').height('50%')
        Text(this.message)
          .fontSize(20).width('100%')
      }
      .width('100%').height('100%')
      .padding(10)
      Column() {
        TextArea({placeholder:'分享新鲜事……'})
          .width('100%')
          .height(180)
          .borderRadius(0)
          .backgroundColor('#FFF3F3F3')
          .placeholderFont({
            size: 18
          })
          .margin({
            top: 12
          })
          .onChange((value: string) => {
            this.keyboardStr = value;
          })

        //添加图片
        Text('选择照片')
          .textAlign(TextAlign.Center)
          .width(120)
          .fontSize(16)
          .fontColor(Color.White)
          .padding(10)
          .margin(20)
          .borderRadius(8)
          .backgroundColor('#FF90D1FD')
          .onClick(async () => {
            this.pictures = await this.mediaHelper.selectPictures();
          })

      }
      .width('100%')
      .height(280)
      .backgroundColor('#FFF3F3F3')
      .margin({
        top: 12
      })

      // TODO-展示图片
      // Image(this.pictures[0])
      // 弄个list就可以了


    }
    .width('100%')
    .height('100%')
    .backgroundColor("#FFEAEAEA")
  }

  @Builder TopBar() {
    Row() {
      Text('取消')
        .height(40)
        .width(66)
        .textAlign(TextAlign.Center)
        .fontSize(20)
        .fontColor(Color.Black)
        .margin({
          left: 12
        })
        .onClick(() => {
          router.back()
        })

      Text('发表动态')
        .fontSize(20)
        .fontColor('#182431')
        .width(88)
        .height(40)
        .textAlign(TextAlign.Center)

      Text('发布')
        .width(66)
        .height(32)
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
        .fontSize(16)
        .backgroundColor('#FF6EC2FA')
        .borderRadius(4)
        .margin({
          right: 12
        })
        .onClick(() => {
          // TODO: 对远程数据进行更新 uid -> momentsList,上传单个动态到后端
          const requestOptions: RequestOptions = {
            url: "http://172.29.4.148:8080/v1/publishMoment",
            method: RequestMethod.POST,
            header: {
              'Content-Type': 'application/json'
            },
            extraData:JSON.stringify({
              momentModel:this.newMoment
            })
          };

          //
          HttpManager.getInstance().request<ResponseResult>(requestOptions)
            .then((result) => {
              if(result.code == '200') {
                // 成功添加动态
                console.info(JSON.stringify(result.data)); //信息

              }
            })
            .catch((err) => {
              console.error(JSON.stringify(err));
            });
        })
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
    .justifyContent(FlexAlign.SpaceBetween)
  }
}