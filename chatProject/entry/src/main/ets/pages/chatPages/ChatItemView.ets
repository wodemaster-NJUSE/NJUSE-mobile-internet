import { ChatContact,
  FileMessage,
  ImageMessage,
  ImageTextMessage,
  MessageBase, MessageBody, TextMessage } from '../../viewmodel/MsgBase';

@Component
  // 聊天对话框
export struct ChatItemView {
  private msg: MessageBase = new MessageBase('', new ChatContact('', ''), new ChatContact('', ''), new MessageBody(), 0);

  build() {
    Column() {
      if (this.msg.from.userId != '1') {
        // 聊天页面对方的消息
        Row() {
          Image(this.msg.from.userImage)
            .width($r('app.integer.opt_layout_chat_view_profile_picture_height'))
            .height($r('app.integer.opt_layout_chat_view_profile_picture_height'))
            .borderRadius($r('app.integer.opt_layout_chat_view_profile_picture_radius'))
          Column() {
            if (this.msg.msgType === 1) {
              Row() {
                Text((this.msg.msgBody as TextMessage).msg)
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
            } else if (this.msg.msgType === 2) {
              Image((this.msg.msgBody as ImageMessage).image)
                .width($r('app.integer.layout_184'))
                .height($r('app.integer.layout_111'))
                .borderRadius($r('app.integer.search_border_radius'))
            }
          }
          .margin({ left: $r('app.integer.layout_8') })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
        .margin({ top: $r('app.integer.layout_12') })
        .padding({ right: $r('app.integer.chat_view_time_width') })
      } else {
        // 聊天页面本人消息
        Row() {
          Image(this.msg.from.userImage)
            .width($r('app.integer.opt_layout_chat_view_profile_picture_height'))
            .height($r('app.integer.opt_layout_chat_view_profile_picture_height'))
            .borderRadius($r('app.integer.opt_layout_chat_view_profile_picture_radius'))
          Column() {
            if (this.msg.msgType === 1) {
              Row() {
                Text((this.msg.msgBody as TextMessage).msg)
                  .lineHeight($r('app.integer.search_text_height'))
                  .constraintSize({ minHeight: $r('app.integer.opt_layout_chat_view_profile_picture_height') })
                  .fontSize($r('app.integer.search_font_size'))
                  .backgroundColor($r('app.color.detail_item_message_background'))
                  .fontColor($r('app.color.top_bar_font_color'))
                  .padding({
                    top: $r('app.integer.layout_8'),
                    left: $r('app.integer.text_font_13'),
                    bottom: $r('app.integer.layout_8'),
                    right: $r('app.integer.text_font_13')
                  })
                  .borderRadius({
                    topLeft: $r('app.integer.opt_layout_chat_view_item_padding_right'),
                    topRight: $r('app.integer.layout_4'),
                    bottomLeft: $r('app.integer.opt_layout_chat_view_item_padding_right'),
                    bottomRight: $r('app.integer.opt_layout_chat_view_item_padding_right')
                  })
              }
            } else if (this.msg.msgType === 2) {
              Image((this.msg.msgBody as ImageMessage).image)
                .width($r('app.integer.layout_184'))
                .height($r('app.integer.layout_111'))
                .borderRadius($r('app.integer.search_border_radius'))
            } else if (this.msg.msgType === 3) {
              // 接收分享的页面
              Column() {
                Text((this.msg.msgBody as ImageTextMessage).msg)
                  .backgroundColor($r('app.color.detail_item_message_image_background'))
                  .width('100%')
                  .fontSize(15)
                  .fontColor($r('app.color.detail_item_message_image_font'))
                  .borderRadius(5)
                  .padding(10)
                Image((this.msg.msgBody as ImageTextMessage).image)
                  .width((this.msg.msgBody as ImageTextMessage).width)
                  .height((this.msg.msgBody as ImageTextMessage).height)
                  .objectFit(ImageFit.Contain)
              }
              .margin({ left: '40%' })
              .padding({ left: '2%', right: '2%', bottom: '2%' })
              .backgroundColor($r('app.color.detail_item_background'))
            } else if (this.msg.msgType == 4) {
              Image((this.msg.msgBody as FileMessage).image)
                .width((this.msg.msgBody as FileMessage).width)
                .height((this.msg.msgBody as FileMessage).height)
                .objectFit(ImageFit.Contain)
            }
          }
          .margin({ right: $r('app.integer.layout_8') })
          .alignItems(HorizontalAlign.End)
        }
        .alignItems(VerticalAlign.Top)
        .width('100%')
        .direction(Direction.Rtl)
        .padding({ left: $r('app.integer.chat_view_time_width') })
        .margin({ top: $r('app.integer.layout_12') })
      }
    }
  }
}
