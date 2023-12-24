import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'

@Entry
@Component
export struct AddFriendPage {
  build() {
    Column() {
      Row()
        .height(20)
        .width('100%')
        .backgroundColor('#ffffff')
      this.Title()
    }
    .width('100%')
    .backgroundColor('#f1f3f5')
  }

  @Builder Title() {
    Row({space: 5}) {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: $r('app.float.image_margin_left'),
          right: $r('app.float.image_margin_right')
        })
        .onClick(() => {
          router.back()
        })

      Text('添加好友界面')
        .fontSize(26)
        .fontColor('#182431')
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}