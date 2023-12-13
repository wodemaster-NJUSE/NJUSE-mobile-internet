import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';

@Component
export struct ContactsComponent {
  build() {
    Column() {
      Row({space: 200}) {
        Text('联系人')
          .fontSize(24)
          .fontColor('#182431')
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width(120)

        Button({type: ButtonType.Normal}) {
          Image($r('app.media.add'))
            .width(26)
            .backgroundColor('#ffffff')
        }
        .onClick(() => {
          router.pushUrl({
              url: CommonConstants.ADD_FRIEND_PAGE_URL
          })
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#ffffff')
    }
  }
}