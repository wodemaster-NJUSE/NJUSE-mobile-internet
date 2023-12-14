import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import { SettingsComponent } from '../view/SettingsComponent';


@Entry
@Component
export struct SettingsPage {
  build() {
    Column() {
      SettingsComponent()
    }
    .width('100%')
    .backgroundColor($r('app.color.moments_page_background'))
  }

}