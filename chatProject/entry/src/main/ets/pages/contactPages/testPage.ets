import { ChatContact, ChatModel } from '../../viewmodel/MsgBase';

@Entry
@Component
@Preview
export struct NewFriendsView {
  private contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);
  // @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
    RelativeContainer() {
      Image($r('app.media.icon'))
        .width($r('app.integer.opt_layout_chat_view_profile_picture_width'))
        .height($r('app.integer.opt_layout_chat_view_profile_picture_height'))
        .borderRadius($r('app.integer.opt_layout_chat_view_profile_picture_radius'))
        .margin({
          top: 10,
          left: 12
        })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .syncLoad(true)
        .id("figure")

      // 红点消息大于0条时渲染红点

        Row() {
          Text(`2`)
            .borderRadius($r('app.integer.layout_8'))
            .constraintSize({minWidth: $r('app.integer.opt_layout_chat_view_red_dot_width')})
            .height($r('app.integer.opt_layout_chat_view_red_dot_height'))
            .backgroundColor($r('app.color.unread_msg_tip'))
            .fontSize($r('app.integer.text_font_10'))
            .textAlign(TextAlign.Center)
            .fontColor(Color.White)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .borderRadius($r('app.integer.layout_10'))
        .margin({ top: 31, right: 18 })
        .constraintSize({minWidth: $r('app.integer.opt_layout_chat_view_red_dot_container_width')})
        .height($r('app.integer.opt_layout_chat_view_red_dot_container_height'))
        .backgroundColor(Color.White)
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          right: { anchor: '__container__', align: HorizontalAlign.End }
        })
        .opacity(1)
        .id('badge')


      // 用户名
      Text('Milo')
        .fontColor($r('app.color.top_bar_font_color'))
        .fontSize($r('app.integer.opt_layout_chat_view_user_name_font_size'))
        .lineHeight($r('app.integer.layout_22'))
        .fontWeight(450)
        .margin({ top: $r('app.integer.layout_10'), left: $r('app.integer.chat_view_row_height') })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .id('user')

      // 最新消息的时间
      Text('22:22')
        .fontSize($r('app.integer.opt_layout_chat_view_item_padding_top'))
        .fontColor(Color.Gray)
        .maxLines(1)
        .textAlign(TextAlign.End)
        .margin({ top: 14, right: 16 })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          right: { anchor: '__container__', align: HorizontalAlign.End }
        })
        .id('time')

      // 最新消息
      Text('# 这是最新消息')
        .fontColor(Color.Gray)
        .fontSize($r('app.integer.text_font_14'))
        .lineHeight($r('app.integer.layout_19'))
        .maxLines(1)
        .margin({ top: $r('app.integer.layout_34'), left: $r('app.integer.chat_view_row_height') })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .id('msg')
    }
    .width($r('app.string.layout_100_percent'))
    .height($r('app.integer.opt_layout_chat_view_item_height'))
    .backgroundColor(Color.White)
    .padding({
      left: $r('app.integer.opt_layout_chat_view_item_padding_left'),
      right: $r('app.integer.opt_layout_chat_view_item_padding_right'),
      top: $r('app.integer.opt_layout_chat_view_item_padding_top'),
      bottom: $r('app.integer.opt_layout_chat_view_item_padding_bottom')
    })
    .onClick(() => {

    })
}}