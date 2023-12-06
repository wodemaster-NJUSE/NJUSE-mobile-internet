import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import {MomentsComponent} from '../view/MomentsComponent';

@Entry
@Component
struct LLMPage {
  build() {
    Column() {
      MomentsComponent()
    }
    .width('100%')
    .backgroundColor($r('app.color.moments_page_background'))
  }
}