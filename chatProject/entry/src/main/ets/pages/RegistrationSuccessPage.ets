import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Page shows registration successful.
 */
@Entry
@Component
struct RegistrationSuccessPage {
  private params = router.getParams() as Record<string, Object>;
  uid : string = this.params.uid as string;
  build() {

    Column() {
      this.TopBar()

      Column() {
        Image($r("app.media.ic_registration_success"))
          .objectFit(ImageFit.Contain)
          .width($r('app.float.registration_success_logo_width'))
          .height($r('app.float.registration_success_logo_height'))
          .margin({
            top : 220
          })

        Text("注册成功，您的uid是:")
          .width($r('app.float.register_success_text_width'))
          .height($r('app.float.register_success_text_height'))
          .textAlign(TextAlign.Center)
          .fontSize(16)
          .fontColor($r('app.color.register_success_text_font'))
          .margin({ top: 10 })

        Text(this.uid)
          .fontColor(Color.Black)
          .fontSize(20)
          .width(200)
          .height(20)
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Bolder)
          .margin({
            top: 6
          })

        Text("点击返回登录界面")
          .width($r('app.float.jump_mine_page_text_width'))
          .height($r('app.float.jump_mine_page_text_height'))
          .textAlign(TextAlign.Center)
          .fontSize(16)
          .fontColor($r('app.color.jump_text_font'))
          .decoration({type : TextDecorationType.Underline, color : '#007DFF' })
          .margin({
            top : 24
          })
          .onClick(() => {
            router.replaceUrl({
              url: CommonConstants.LOGIN_PAGE_URL
            });
          })
      }
      .width(CommonConstants.REGISTRATION_PAGE_WIDTH_PERCENT)
      .height(CommonConstants.REGISTRATION_PAGE_HEIGHT_PERCENT)


    }
  }

   @Builder TopBar() {
    Row() {
      // Image($r('app.media.ic_back'))
      //   .width($r('app.float.image_size'))
      //   .height($r('app.float.image_size'))
      //   .margin({
      //     left: $r('app.float.image_margin_left'),
      //     right: $r('app.float.image_margin_right')
      //   })
      //   .onClick(() => {
      //     router.back();
      //   })

      // Text($r('app.string.register_success_text'))
      //   .fontSize($r('app.float.title_text_size'))
      //   .fontColor($r('app.color.title'))
      //   .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}