import router from '@ohos.router';
import {CommonConstants} from '../../common/constants/CommonConstants';
import {User} from '../../model/UserModel'


@Entry
@Component
struct mySettingPage {
  user : User = new User($r('app.media.profile_photo_3'),"Milo","# 这是一个签名","男");

  @State profilePicture : Resource = this.user.profilePicture
  @State userName : string = this.user.userName
  @State signature : string = this.user.signature
  @State gender : string = this.user.gender

    build() {
      Column() {
        this.TopBar()

        this.PersonalMsgList()
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
            .width(50)
            .margin({left: 12})
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height(40)
      .backgroundColor(Color.White)
      .borderRadius({
        topLeft: 4,
        topRight: 4
      })

      // 用户名
      ListItem() {
        Row() {
          Text('test2')
        }
      }
      .width('100%')
      .height(40)
      .backgroundColor(Color.White)

      // 性别
      ListItem() {
        Row() {
          Text('test2')
        }
      }
      .width('100%')
      .height(40)
      .backgroundColor(Color.White)

      // 签名
      ListItem() {
        Row() {
          Text('test2')
        }
      }
      .width('100%')
      .height(40)
      .backgroundColor(Color.White)

      // 个人空间
      ListItem() {
        Row() {
          Text('test2')
        }
      }
      .width('100%')
      .height(40)
      .backgroundColor(Color.White)
      .borderRadius({
        bottomLeft: 4,
        bottomRight: 4
      })
    }
    .width('90%')
    .height(400)
    .divider({
      strokeWidth: '4px',
      startMargin: 6,
      endMargin: 6,
      color: "#FFEAEAEA"
    })
  }
}