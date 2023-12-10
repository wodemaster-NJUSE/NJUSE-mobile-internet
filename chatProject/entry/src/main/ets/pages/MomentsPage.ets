import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import {MomentsComponent} from '../view/MomentsComponent';

@Entry
@Component
export struct MomentsPage {
  build() {
    Column() {
      MomentsComponent()
    }
    .width('100%')
    .backgroundColor($r('app.color.moments_page_background'))
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

      Text("moment")
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}