import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';

@Component
export struct MomentsComponent {
  build() {
    Column() {
      Row() {
        Text('动态界面')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
      }.width('100%')
    }
  }
}