import { CommonConstants } from '../../common/constants/CommonConstants';
import { ChatContact, ChatModel } from '../../viewmodel/MsgBase';

@Entry
@Component
@Preview
export struct NewFriendsView {
  private contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);
  // @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
    Column() {}
  }

  @Builder TopBar() {
    Row() {
      // Image($r('app.media.ic_back'))
      //   .width($r('app.float.image_size'))
      //   .height($r('app.float.image_size'))
      //   .margin({
      //     left: $r('app.float.image_margin_left'),
      //     right: $r('app.float.image_margin_right')
      //   })
      //   .onClick(() => {
      //     router.back()
      //   })

      Text('取消')



      Text('个人信息编辑')
        .fontSize(20)
        .fontColor('#182431')
        .width('40%')
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