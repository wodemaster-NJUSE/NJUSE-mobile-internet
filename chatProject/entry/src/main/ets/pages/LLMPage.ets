import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import {LLMComponent} from '../view/LLMComponent';

@Entry
@Component
export struct LLMPage {
    build() {
        Column() {
            LLMComponent()
        }
        .width('100%')
        .backgroundColor($r('app.color.llm_page_background'))
    }

}