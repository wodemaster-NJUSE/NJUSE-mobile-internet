import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import {ContactsComponent} from '../view/ContactsComponent';

@Entry
@Component
export struct ContactsPage {
  build() {
    Column() {
      ContactsComponent()
    }
    .width('100%')
    .backgroundColor($r('app.color.contacts_page_background'))
  }
}