import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { UserDataGet } from '../stores/user';

/**
 * Page shows registration successful.
 */
@Entry
@Component
struct RegistrationSuccessPage {
  private params = router.getParams() as Record<string, Object>;
  uid : string | Resource = this.params.chatName as string | Resource;
  build() {

    Column() {
      this.Title()

      Scroll() {
        Column() {
          Image($r("app.media.ic_registration_success"))
            .objectFit(ImageFit.Contain)
            .width($r('app.float.registration_success_logo_width'))
            .height($r('app.float.registration_success_logo_height'))

          Text($r('app.string.register_success_text')+"你的uid是"+ this.uid+" 请用uid登录")
            .width($r('app.float.register_success_text_width'))
            .height($r('app.float.register_success_text_height'))
            .textAlign(TextAlign.Center)
            .fontSize($r('app.float.register_success_text_font_size'))
            .fontColor($r('app.color.register_success_text_font'))
            .margin({ top: $r('app.float.register_success_text_margin_top') })

          Text("点击返回登录界面")
            .width($r('app.float.jump_mine_page_text_width'))
            .height($r('app.float.jump_mine_page_text_height'))
            .textAlign(TextAlign.Center)
            .fontSize($r('app.float.jump_text_font_size'))
            .fontColor($r('app.color.jump_text_font'))
            .onClick(() => {
              router.replaceUrl({
                url: CommonConstants.LOGIN_PAGE_URL
              });
            })
        }
        .width(CommonConstants.REGISTRATION_PAGE_WIDTH_PERCENT)
        .height(CommonConstants.REGISTRATION_PAGE_HEIGHT_PERCENT)
        .justifyContent(FlexAlign.Center)
      }
      .layoutWeight(CommonConstants.SCROLL_LAYOUT_WEIGHT)
    }
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