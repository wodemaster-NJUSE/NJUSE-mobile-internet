import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'


@Entry
@Component
export struct NewFriendsPage {
  build() {
    Column(){
      this.TopBar()

      
    }
  }

  // 顶部导航栏
  @Builder TopBar() {
    Row() {
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

      Text('新的朋友')
        .fontSize(26)
        .fontColor('#182431')
        .width('30%')
        .textAlign(TextAlign.Center)

      Text().width('24vp').margin({
        left: '16vp',
        right: '24vp'
      })
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
    .justifyContent(FlexAlign.SpaceBetween)
  }
}