import router from '@ohos.router';
import {CommonConstants} from '../../common/constants/CommonConstants';
import {User} from '../../model/UserModel'


@Entry
@Component
struct SettingsPage {
  scroller: Scroller = new Scroller();

  // 用户类
  // todo：需要与后端进行通信，包括读取数据与更新数据
  user : User = new User($r('app.media.profilePicture01'),"张三","李四吃饱了","武装直升机");

  // 这些属性与子组件双向绑定，他们发生更新时，渲染也会发生变化。更新时，记得在代码中写出对 user 对象的更新
  @State profilePicture : Resource = this.user.profilePicture
  @State userName : string = this.user.userName
  @State signature : string = this.user.signature
  @State gender : string = this.user.gender


  param = router.getParams()
  // newTextValue = this.param['newTextValue']

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
          .onClick(() => {
            // todo：双向绑定测试，通信成功后删除
            this.userName = "王五"
            this.user.userName = this.userName
          })
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))

      // 设置项
      List({ space: 2 }) {
        ListItem() {
          settingImageItem({
            title : "头像",
            imageContent : $profilePicture,
            pushUrl : CommonConstants.SETTING_PROFILE_PICTURE_PAGE_URL
          })
        }
        ListItem() {
          settingTextItem({
            title : "用户名",
            textContent : $userName,
            pushUrl : CommonConstants.SETTING_USERNAME_PAGE_URL
          })
        }
        ListItem() {
          settingTextItem({
            title : "签名",
            textContent : $signature,
            pushUrl : CommonConstants.SETTING_SIGNATURE_PAGE_URL
          })
        }
        ListItem() {
          settingTextItem({
            title : "性别",
            textContent : $gender,
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
            router.replaceUrl(
              { url: CommonConstants.LOGIN_PAGE_URL },
              router.RouterMode.Single,)
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

// 单个文本设置项
@Component
struct settingTextItem {
  // 标题
  title : string

  // 文本内容
  @Link
  textContent : string

  // 跳转地址
  pushUrl : string

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

// 单个图片设置项
@Component
struct settingImageItem {
  // 标题
  title : string

  // 图片内容
  @Link
  imageContent : Resource

  // 跳转地址
  pushUrl : string

  build() {
    Row() {
      // 设置项
      Text(this.title)
        .fontSize($r('app.integer.setting_page_attribute_font_size'))
        .layoutWeight(2)
      // 设置项的当前图片内容
      Image(this.imageContent)
        .align(Alignment.End)
        .opacity($r('app.float.setting_menu_arrow_opacity'))
        .objectFit(ImageFit.Contain)
        .size({
          height : '48vp',
          width : '48vp'
        })
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