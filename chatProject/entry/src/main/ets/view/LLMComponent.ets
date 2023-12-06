import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';

@Component
export struct LLMComponent {
    build() {
        Column() {
            Row() {
                Text('大语言界面')
                    .fontSize(40)
                    .fontWeight(FontWeight.Bold)
            }.width('100%')
        }
    }
}