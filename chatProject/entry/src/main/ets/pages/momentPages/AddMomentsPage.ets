import { ChatContact, FriendMoment } from '../../viewmodel/MsgBase';
import picker from '@ohos.file.picker';
import common from '@ohos.app.ability.common';
import fs from '@ohos.file.fs';
import request from '@ohos.request';
import { MediaBean, MediaHelper } from './MediaHelper';
import { RequestMethod, RequestOptions } from '../../utils/http/RequestOptions';
import { HttpManager } from '../../utils/http/HttpManager';
import { ResponseResult } from '../../utils/http/HttpCore';

// 获取应用文件路径
let context = getContext(this) as common.UIAbilityContext;
let cacheDir = context.cacheDir;

// 上传任务配置项
let uploadConfig = {
  url: 'http://192.168.3.48:8740/file/upload',
  header: { key1: 'Content-Type', key2: 'multipart/form-data' },
  method: 'POST',
  files: [], // 存放图片
  data: [
    {
      uid: '',
      user: ChatContact,
      content: '',
      time: '',
      media: '', // media为需要获取的视频url
      mediaPreview: '' //mediaPreview为需要获取的视频预览图url
    }
  ]
}
@Entry
@Component
export struct AddMomentsPage {
  // 添加新动态，点击发表的时候要更新动态列表
  uid: string = ''; // 通过uid来向后端获取对应的数据
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
  // uploadMoment() {
  //   // 将本地应用文件上传至网络服务器
  //   try {
  //     uploadConfig.data = [{
  //       uid: this.uid,
  //       user: ChatContact,
  //       content: this.keyboardStr,
  //       time: this.time.toString(),
  //       media: '', // media为需要获取的视频url
  //       mediaPreview: '' //mediaPreview为需要获取的视频预览图url
  //     }]
  //     // Clear the existing files in the upload configuration
  //     uploadConfig.files = [];
  //     // Add each selected image to the upload configuration
  //     for (let i = 0; i < this.pictures.length; i++) {
  //       let uri = this.pictures[i];
  //       let filename = `image_${i}.jpg`; // You can customize the filename as needed
  //       uploadConfig.files.push({ filename, name: 'image', uri, type: 'jpg' });
  //     }
  //
  //     // Upload the files to the server
  //     request.uploadFile(context, uploadConfig)
  //       .then((uploadTask) => {
  //         uploadTask.on('complete', (taskStates) => {
  //           for (let i = 0; i < taskStates.length; i++) {
  //             console.info(`xx upload complete taskState: ${JSON.stringify(taskStates[i])}`);
  //           }
  //         });
  //       })
  //       .catch((err) => {
  //         console.error(`xx Invoke uploadFile failed, code is ${err.code}, message is ${err.message}`);
  //
  //       })
  //   } catch (err) {
  //     console.error(`xx Invoke uploadFile failed, code is ${err.code}, message is ${err.message}`);
  //
  //   }
  // }
  build() {
    Column() {

      Stack() {
        // 取消    写说说     发表按钮
        Text('发送')
          .borderRadius(2)
          .height(36)
          .width(62)
          .backgroundColor('#FF6EC2FA')
          .fontColor(Color.White)
          .fontSize(12)
          .margin({ right: 10 })
          .textAlign(TextAlign.Center)
          .onClick(() => {
            //TODO: 对远程数据进行更新 uid -> momentsList,上传单个动态到后端
          })
      }
      // 动态构建
      TextInput({placeholder:'分享新鲜事……'})
        .onChange((value: string) => {
          this.keyboardStr = value;
        })

      //添加图片
      Text('选择图片')
          .textAlign(TextAlign.Center)
          .width(200)
          .fontSize(16)
          .padding(10)
          .margin(20)
          .border({ width: 0.5, color: '#ff38f84b', radius: 15 })
          .onClick(async () => {
            this.pictures = await this.mediaHelper.selectPictures();
          })
      //展示图片
      Image(this.pictures[0])
      // 弄个list就可以了


    }
  }
}