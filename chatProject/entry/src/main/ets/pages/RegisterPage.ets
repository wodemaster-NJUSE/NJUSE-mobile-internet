import router from '@ohos.router';
import webview from '@ohos.web.webview';
import { CommonConstants } from '../common/constants/CommonConstants';
import { PrivacyStatementComponent } from '../view/PrivacyStatementComponent';
import { RegisterComponent } from '../view/RegisterCompoent';

@Entry
@Component
struct RegisterPage {
  build() {
    Column() {
      this.Title() //退出按钮
      Scroll() {
        Column() {
          RegisterComponent()

          Blank()

          PrivacyStatementComponent()
        }
        .height(CommonConstants.SCROLL_HEIGHT_PERCENT)
        .constraintSize({ minHeight: $r('app.float.scroll_min_height') })
        .alignItems(HorizontalAlign.Start)
        .padding($r('app.float.login_operation_area_padding'))
      }
      .layoutWeight(1)

    }.width('100%')
    .backgroundColor($r('app.color.register_page_background'))
  }

  @Builder Title() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: $r('app.float.image_margin_left'),
          right: $r('app.float.image_margin_right')
        })
        .onClick(() => {
          router.back();
        })

      Text($r('app.string.register_success_text'))
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}