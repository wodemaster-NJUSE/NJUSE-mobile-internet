import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'

@Entry
@Component
export struct AddFriendsPage {
  @State submitValue: string = ''
  search_placeholder: string = '请输入您要搜索的UID'

  build() {
    Column() {
      this.Title()

      // 搜索框
      Text('submitValue:' + this.submitValue).fontSize(18).margin(15)
      Search({placeholder: this.search_placeholder})
        .searchButton('搜索')
        .width('90%')
        .height(40)
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Gray)
        .placeholderFont({size: 14, weight: 400})
        .textFont({size: 14,weight: 400})
        .onSubmit((value: string) => {
          this.submitValue = value
        })
        .margin(20)

    }
    .width('100%')
    .backgroundColor('#ffffff')
  }

  // 顶部导航栏
  @Builder Title() {
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

      Text('添加好友')
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