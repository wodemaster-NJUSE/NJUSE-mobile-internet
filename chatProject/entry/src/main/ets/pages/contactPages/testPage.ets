import { ChatContact, ChatModel } from '../../viewmodel/MsgBase';

@Entry
@Component
@Preview
export struct NewFriendsView {
  private contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);
  // @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
    Row() {
      Image($r('app.media.icon'))
        .width($r('app.integer.opt_layout_chat_view_profile_picture_height'))
        .height($r('app.integer.opt_layout_chat_view_profile_picture_height'))
        .borderRadius($r('app.integer.opt_layout_chat_view_profile_picture_radius'))
      Column() {
        LoadingProgress()
          .color(Color.Blue)
          .width(184)
          .height(111)


        Text('jasbkdhbasd')
          .lineHeight($r('app.integer.search_text_height'))
          .constraintSize({ minHeight: $r('app.integer.search_inline_height') })
          .fontSize($r('app.integer.search_font_size'))
          .fontColor($r('app.color.top_bar_font_color'))
          .backgroundColor(Color.White)
          .padding({
            top: $r('app.integer.layout_8'),
            left: $r('app.integer.text_font_13'),
            bottom: $r('app.integer.layout_8'),
            right: $r('app.integer.text_font_13')
          })
          .borderRadius({ topLeft: $r('app.integer.layout_4'),
            topRight: $r('app.integer.opt_layout_chat_view_item_padding_right'),
            bottomLeft: $r('app.integer.opt_layout_chat_view_item_padding_right'),
            bottomRight: $r('app.integer.opt_layout_chat_view_item_padding_right')
          })
      }
      .margin({ left: $r('app.integer.layout_8') })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .margin({ top: $r('app.integer.layout_12') })
    .padding({ right: $r('app.integer.chat_view_time_width') })
  }
}