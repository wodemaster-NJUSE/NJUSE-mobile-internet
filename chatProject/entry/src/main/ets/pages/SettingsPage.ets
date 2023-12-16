import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import {User} from 'ets/model/UserModel'


@Entry
@Component
struct SettingsPage {
  scroller: Scroller = new Scroller();
  user : User = new User($r('app.media.profilePicture01'),"张三","李四吃饱了","武装直升机");

  build() {
    Column() {
      // 顶层栏
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({
            left: $r('app.float.setting_page_padding'),
            right: $r('app.float.image_margin_right')
          })
          .onClick(() => {
            router.back();
          })

        Text($r('app.string.setting'))
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))

      // 设置项
      List({ space: 2 }) {
        // ListItem示例：昵称
        // ListItem() {
        //   Row() {
        //     Text($r('app.string.nickname'))
        //       .fontSize($r('app.integer.setting_page_font_size'))
        //       .layoutWeight(1)
        //     Image($r('app.media.right_arrow'))
        //       .height($r('app.integer.setting_menu_arrow_height'))
        //       .width($r('app.integer.setting_menu_arrow_width'))
        //       .align(Alignment.End)
        //       .opacity($r('app.float.setting_menu_arrow_opacity'))
        //       .objectFit(ImageFit.Contain)
        //   }
        //   .padding({
        //     left : this.universal_margin,
        //     top : this.universal_margin,
        //     bottom : this.universal_margin,
        //   })
        //   .width($r('app.string.layout_100'))
        //   .backgroundColor($r("app.color.setting_front"))
        // }

        ListItem() {
          settingItem({
            title : "头像",
            imageContent : this.user.profilePicture,
            pushUrl : CommonConstants.SETTING_PROFILE_PICTURE_PAGE_URL
          })
        }
        ListItem() {
          settingItem({
            title : "用户名",
            textContent : this.user.userName,
            pushUrl : CommonConstants.SETTING_USERNAME_PAGE_URL
          })
        }
        ListItem() {
          settingItem({
            title : "签名",
            textContent : this.user.signature,
            pushUrl : CommonConstants.SETTING_SIGNATURE_PAGE_URL
          })
        }
        ListItem() {
          settingItem({
            title : "性别",
            textContent : this.user.gender,
            pushUrl : CommonConstants.SETTING_GENDER_PAGE_URL
          })
        }
      }
      .width($r('app.string.layout_100'))
      .margin({bottom : 12})


      // 退出登录
      Row() {
        Text("退出账号")
          .fontSize($r('app.integer.setting_page_attribute_font_size'))
          .onClick(() => {
            // todo: 请先销毁登录时创建的资源！
            router.pushUrl({
              url: CommonConstants.LOGIN_PAGE_URL
            })
          })
          .margin({top : 2, bottom : 2})
      }
      .padding({
        top : $r('app.float.setting_page_padding'),
        bottom : $r('app.float.setting_page_padding'),
      })
      .justifyContent(FlexAlign.Center)
      .width($r('app.string.layout_100'))
      .backgroundColor($r("app.color.setting_front"))
    }
    .width($r('app.string.layout_100'))
    .height($r('app.string.layout_100'))
    .backgroundColor($r("app.color.setting_background"))
  }
}

// 单个设置项
@Component
struct settingItem {
  // 标题
  title = null
  // 文本内容
  textContent = null
  // 图片内容
  imageContent = null
  // 跳转地址
  pushUrl = null

  build() {
    Row() {
      // 设置项
      Text(this.title)
        .fontSize($r('app.integer.setting_page_attribute_font_size'))
        .layoutWeight(2)
      // 设置项的当前文字内容
      Text(this.textContent)
        .fontSize($r('app.integer.setting_page_content_font_size'))
        .layoutWeight(8)
        .fontColor($r('app.color.setting_content'))
        .textAlign(TextAlign.End)
      // 设置项的当前图片内容
      if (this.imageContent != null) {
        Image(this.imageContent)
          .align(Alignment.End)
          .opacity($r('app.float.setting_menu_arrow_opacity'))
          .objectFit(ImageFit.Contain)
          .size({
            height : '48vp',
            width : '48vp'
          })
      }
      // 右箭头
      Image($r('app.media.right_arrow'))
        .height($r('app.integer.setting_menu_arrow_height'))
        .width($r('app.integer.setting_menu_arrow_width'))
        .align(Alignment.End)
        .opacity($r('app.float.setting_menu_arrow_opacity'))
        .objectFit(ImageFit.Contain)
        .margin({left : $r('app.float.setting_page_padding')})
    }
    .onClick(() => {
      router.pushUrl({
        url: this.pushUrl
      })
    })
    .padding({
      left : $r('app.float.setting_page_padding'),
      right : $r('app.float.setting_page_padding'),
      top : $r('app.float.setting_page_padding'),
      bottom : $r('app.float.setting_page_padding'),
    })
    .width($r('app.string.layout_100'))
    .backgroundColor($r("app.color.setting_front"))
  }
}

