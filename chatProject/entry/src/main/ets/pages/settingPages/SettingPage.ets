import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import {CommonConstants} from '../../common/constants/CommonConstants';
import {User} from '../../model/UserModel'
import { RequestMethod, RequestOptions } from '../../utils/http/RequestOptions';
import { HttpManager } from '../../utils/http/HttpManager';
import { ResponseResult } from '../../utils/http/HttpCore';
import { getAvatar } from '../../utils/Constants';


@Entry
@Component
struct mySettingPage {
  user : User = new User($r('app.media.profile_photo_3'),"Milo","# 这是一个签名","男");

  @State profilePicture : Resource = this.user.profilePicture
  @State userName : string = globalThis.USERNAME
  @State signature : string = globalThis.MOTTO
  @State gender : string = globalThis.GENDER

  @State isChanged : boolean = false;

    build() {
      Column() {
        this.TopBar()

        this.PersonalMsgList()

        Row() {
          // 保存修改按钮
          Button('保存修改', {type: ButtonType.Normal, stateEffect: true})
            .borderRadius(8)
            .fontSize(18)
            .backgroundColor('#317aff')
            .width('45%')
            .enabled(this.isChanged)
            .onClick(() => {
              // TODO-修改个人信息
              const requestOptions: RequestOptions = {
                url: "http://172.29.4.148:8080/v1/setting",//
                method: RequestMethod.POST,
                header: {
                  'Content-Type': 'application/json'
                },
                extraData: JSON.stringify({
                  uid : globalThis.UID,
                  userName : this.userName,
                  signature : this.signature,
                  gender : this.gender
                })
              };
              // 调用HttpManager的request方法，发起POST请求
              HttpManager.getInstance().request<ResponseResult>(requestOptions)
                .then((result) => {
                  console.info('修改个人信息');//输出
                })
                .catch((err) => {
                  console.error(JSON.stringify(err));
                });

            })

          // 退出登录按钮
          Button('退出登录', {type: ButtonType.Normal, stateEffect: true})
            .borderRadius(8)
            .backgroundColor('0x317aff')
            .width('45%')
            .backgroundColor('#FFFA0404')
            .fontSize(18)
            .onClick(() => {
              // TODO-退出登录
              globalThis.context.terminateSelf();
            })
        }
        .width('90%')
        .height('48vp')
        .margin({top: 18})
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .height('100%')
      .backgroundColor("#FFEAEAEA")
    }

  @Builder TopBar() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: $r('app.float.image_margin_left'),
          right: $r('app.float.image_margin_right')
        })
        .onClick(() => {
          router.back()
        })

      Text('个人信息编辑')
        .fontSize(20)
        .fontColor('#182431')
        .width('40%')
        .textAlign(TextAlign.Center)

      Text().width('24vp').margin({
        left: '16vp',
        right: '24vp'
      })
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({top:20})
  }

  // 个人信息列表
  @Builder PersonalMsgList() {
    List() {
      // 头像
      ListItem() {
        Row() {
          Text('头像')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .layoutWeight(1)
            .margin({left: 12})

          Image(getAvatar(globalThis.UID))
            .height(54)
            .width(54)
            .borderRadius(27)
            .margin({right: 20})
            .align(Alignment.End)
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .borderRadius(8)
    }
    .width('90%')
    .height(80)


    List() {
      // 用户名
      ListItem() {
        Row() {
          Text('用户名')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .width('20%')
            .margin({left: 12})

          // Text(this.userName)
          //   .fontSize(18)
          //   .textAlign(TextAlign.Start)
          //   .height('100%')
          //   .width('75%')
          TextInput({placeholder : globalThis.USERNAME})
            .placeholderFont({size : 18})
            .placeholderColor(Color.Black)
            .height('100%')
            .width('80%')
            .borderRadius(0)
            .backgroundColor(Color.White)
            .onChange((value: string) => {
              this.userName = value;
              globalThis.USERNAME = value;
              this.isChanged = true;
            })
        }
      }
      .width('100%')
      .height(46)
      .backgroundColor(Color.White)
      .borderRadius({
        topLeft : 8,
        topRight : 8
      })

      // 性别
      ListItem() {
        Row() {
          Text('性别')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .width('20%')
            .margin({left: 12})

          Text(this.gender)
            .fontSize(18)
            .textAlign(TextAlign.Start)
            .height('100%')
            .width('80%')
            .padding({left: 15})
        }
      }
      .width('100%')
      .height(46)
      .backgroundColor(Color.White)
      .onClick(() => {
        try {
          promptAction.showDialog({
            message: '选择性别',
            buttons: [{
              text : '男',
              color : '#000000'
            },
              {
              text : '女',
              color : '#000000'
            }],
          })
            .then(data => {
              this.isChanged = true;
              if (data.index === 0) {
                this.gender = '男';
                globalThis.GENDER = '男';
              } else {
                this.gender = '女';
                globalThis.GENDER = '女';
              }
            })
            .catch(err => {
              console.info('SettingPage showDialog error: ' + err);
            })
        } catch (error) {
          console.error(`SettingPage showDialog args error code is ${error.code}, message is ${error.message}`);
        }
      })

      // 签名
      ListItem() {
        Row() {
          Text('签名')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .width('20%')
            .margin({left: 12})

          // Text(this.signature)
          //   .fontSize(18)
          //   .textAlign(TextAlign.Start)
          //   .maxLines(1)
          //   .height('100%')
          //   .width('75%')

          TextInput({placeholder : globalThis.MOTTO})
            .placeholderFont({size : 18})
            .placeholderColor(Color.Black)
            .height('100%')
            .width('80%')
            .borderRadius(0)
            .backgroundColor(Color.White)
            .onChange((value: string) => {
              this.signature = value;
              globalThis.MOTTO = value;
              this.isChanged = true;
            })
        }
      }
      .width('100%')
      .height(46)
      .backgroundColor(Color.White)
      .borderRadius({
        bottomLeft: 8,
        bottomRight: 8
      })
    }
    .width('90%')
    .height('140')
    .divider({
      strokeWidth: '4px',
      startMargin: 6,
      endMargin: 6,
      color: "#FFEAEAEA"
    })
    .margin({
      top: 12
    })

    // 空间
    List() {
      ListItem() {
        Row() {
          Text('我的空间')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .layoutWeight(1)
            .margin({left: 12})

          Image($r('app.media.right_arrow'))
            .height(18)
            .width(18)
            .objectFit(ImageFit.Contain)
            .margin({right: 12})
            .align(Alignment.End)
        }
      }
      .width('100%')
      .height(46)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .onClick(() => {
        // TODO-进入个人空间
      })
    }
    .width('90%')
    .height(50)
    .divider({
      strokeWidth: '4px',
      startMargin: 6,
      endMargin: 6,
      color: "#FFEAEAEA"
    })
    .margin({
      top: 12
    })
  }
}
