import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { myRegisterComponent } from '../view/myRegisterComponent';
import { PrivacyStatementComponent } from '../view/PrivacyStatementComponent';
import { RegisterComponent } from '../view/RegisterCompoent';

@Entry
@Component
struct RegisterPage {
  build() {
    Column() {
      this.TopBar() //退出按钮

      Scroll() {
        Column() {
          myRegisterComponent()
          // RegisterComponent()

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
    .backgroundColor($r('app.color.login_page_background_color'))
  }

  @Builder TopBar() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: 16,
          right: $r('app.float.image_margin_right')
        })
        .onClick(() => {
          router.back();
        })
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}