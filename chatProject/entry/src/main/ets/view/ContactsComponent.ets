import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';

@Component
export struct ContactsComponent {
  build() {
    Column() {
      Row() {
        Text('联系人界面')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
      }.width('100%')
    }
  }
}