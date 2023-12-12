import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';

@Component
export struct SettingsComponent {
  build() {
    Column() {
      Row() {
        Text('设置界面')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
      }.width('100%')
    }
  }
}