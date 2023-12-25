import { ChatContact, ChatModel } from '../../viewmodel/MsgBase';

@Entry
@Component
@Preview
export struct NewFriendsView {
  private contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);
  // @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
      Column() {
        List() {

        }
        .backgroundColor(Color.White)
        .listDirection(Axis.Vertical)
        .divider({
          strokeWidth: $r('app.integer.chat_list_divider_stroke_width'),
          color: $r('app.color.chat_list_divider_color'),
          startMargin: $r('app.integer.chat_list_page_start_margin'),
          endMargin: $r('app.integer.opt_layout_chat_view_item_padding_right')
        })
        .height($r('app.string.layout_82'))
        .width($r('app.string.layout_100'))
      }
}}