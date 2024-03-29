import Logger from '../utils/Logger';
import { ChatModel, ChatContact } from '../viewmodel/MsgBase';
import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { getAvatar } from '../utils/Constants';

const TAG: string = 'ChatList_ChatView';

/**
 * 可复用且优化布局的聊天页面组件
 */
// @Reusable
@Component
export struct ReusableChatView {
  @State chatItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);

  aboutToReuse(params: Record<string, Object>): void {
    this.chatItem = params.chatItem as ChatModel;
    Logger.info(TAG, 'aboutToReuse=' + this.chatItem.toString());
  }

  build() {
    ChatView({ chatItem: this.chatItem });
  }
}

/**
 * 优化布局的聊天页面组件
 */
@Preview
@Component
export struct ChatView {
  private chatItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);
  @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
    RelativeContainer() {
      Image(getAvatar(this.chatItem.user.userId))
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
        .syncLoad(this.imageSyncLoad ? true : false)
        .id("figure")

      // 红点消息大于0条时渲染红点
      // 红点在头像右上方
      // if (this.chatItem.unreadMsgCount > 0) {
      //   Row() {
      //     Text(`${this.chatItem.unreadMsgCount}`)
      //       .borderRadius($r('app.integer.layout_8'))
      //       .constraintSize({minWidth: $r('app.integer.opt_layout_chat_view_red_dot_width')})
      //       .height($r('app.integer.opt_layout_chat_view_red_dot_height'))
      //       .backgroundColor($r('app.color.unread_msg_tip'))
      //       .fontSize($r('app.integer.text_font_10'))
      //       .textAlign(TextAlign.Center)
      //       .fontColor(Color.White)
      //   }
      //   .alignItems(VerticalAlign.Center)
      //   .justifyContent(FlexAlign.Center)
      //   .borderRadius($r('app.integer.layout_10'))
      //   .margin({ top: $r('app.integer.layout_8'), left: $r('app.integer.layout_40') })
      //   .constraintSize({minWidth: $r('app.integer.opt_layout_chat_view_red_dot_container_width')})
      //   .height($r('app.integer.opt_layout_chat_view_red_dot_container_height'))
      //   .backgroundColor(Color.White)
      //   .alignRules({
      //     top: { anchor: '__container__', align: VerticalAlign.Top },
      //     left: { anchor: '__container__', align: HorizontalAlign.Start }
      //   })
      //   .opacity(this.chatItem.unreadMsgCount > 0 ? 1 : 0)
      //   .id('badge')
      // }
      // 红点在日期下方
      if (this.chatItem.unreadMsgCount > 0) {
        Row() {
          Text(`${this.chatItem.unreadMsgCount}`)
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
        .opacity(this.chatItem.unreadMsgCount > 0 ? 1 : 0)
        .id('badge')
      }

      // 用户名
      Text(this.chatItem.user.userName)
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
      Text(this.chatItem.lastTime)
        .fontSize($r('app.integer.opt_layout_chat_view_item_padding_top'))
        .fontColor(Color.Gray)
        .maxLines(1)
        .textAlign(TextAlign.End)
        .margin({ top: $r('app.integer.layout_16'), right: $r('app.integer.layout_16') })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          right: { anchor: '__container__', align: HorizontalAlign.End }
        })
        .id('time')

      // 最新消息
      Text(this.chatItem.lastMsg)
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
      router.pushUrl({
        url: CommonConstants.DETAIL_PAGE_URL,
        params: {
          chatName: this.chatItem.user.userName,
          chatId: this.chatItem.user.userId,
          chatImg: this.chatItem.user.userImage,
          lastMsg: this.chatItem.lastMsg
        }
      }, (err) => {
        if (err) {
          Logger.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
          return;
        }
        Logger.info('pushUrl success');
      })
    })

  }
}
