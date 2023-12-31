import MediaQueryModel from '../model/MediaQueryModel';
import { CommonConstants } from '../common/constants/CommonConstants';
import { PrivacyStatementComponent } from '../view/PrivacyStatementComponent';
import { LoginComponent } from '../view/LoginComponent';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct LoginPage {
  private preTime: number = -1;

  aboutToAppear() {
    MediaQueryModel.register();
  }

  aboutToDisappear() {
    MediaQueryModel.unRegister();
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          LoginComponent()

          Blank()

          PrivacyStatementComponent()
        }
        .height(CommonConstants.SCROLL_HEIGHT_PERCENT)
        .constraintSize({ minHeight: $r('app.float.scroll_min_height') })
        .alignItems(HorizontalAlign.Start)
        .padding($r('app.float.login_operation_area_padding'))
      }
      .layoutWeight(CommonConstants.LOGIN_SCROLL_LAYOUT_WEIGHT)
    }
    .width(CommonConstants.LOGIN_PAGE_WIDTH_PERCENT)
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
          let currentTime = new Date().getTime()
          console.info('login_: ' + this.preTime);
          if (currentTime - this.preTime > 2000) {
            promptAction.showToast({
              message: "再按一次退出应用"
            })
            this.preTime = currentTime;
          } else {
            console.info("close_abi");
            globalThis.context.terminateSelf();
          }
        })
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
     .margin({
       top: 20
     })
  }
}