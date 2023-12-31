import { ChatContact, ChatModel } from '../../viewmodel/MsgBase';

@Entry
@Component
@Preview
export struct NewFriendsView {
  private contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);
  // @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      TextArea({ placeholder: ''})
        .id('bottomTextInput')
        .height(30)
        .layoutWeight(1)
        .borderRadius(2)
        .backgroundColor(Color.White)
        .margin({
          left: 8,
          right: 8
        })

      Text('发送')
        .borderRadius(2)
        .height(30)
        .width(52)
        .backgroundColor('#FF6EC2FA')
        .fontColor(Color.White)
        .fontSize(12)
        .margin({ right: 10 })
        .textAlign(TextAlign.Center)

    }
    .backgroundColor('#FFF3F3F3')
    .width($r('app.string.layout_100'))
    .height(46)
  }
}