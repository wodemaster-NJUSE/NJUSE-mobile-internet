import { ChatModel} from '../viewmodel/MsgBase'
import Logger from '../utils/Logger';
import router from '@ohos.router';
import { ChatContact } from '../viewmodel/MsgBase';
import { CommonConstants } from '../common/constants/CommonConstants';

const TAG: string = 'NewFriendsList_NewFriendsView';

// @Reusable
@Component
export struct ReusableNewFriendsView {
  // 联系人列表单个项
  @State contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);

  aboutToReuse(params: Record<string, Object>): void {
    this.contactItem = params.contactItem as ChatModel;
    Logger.info(TAG, 'aboutToReuse=' + this.contactItem.toString());
  }

  build() {
    NewFriendsView({ contactItem: this.contactItem })
  }
}

@Component
@Preview
export struct NewFriendsView {
  private contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);
  @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.TopEnd }) {
          // 用户头像
          Image(this.contactItem.user.userImage)
            .width($r('app.integer.contact_view_image_width'))
            .height($r('app.integer.contact_view_image_height'))
            .margin({ left: $r('app.integer.contact_view_image_margin_left') })
            .borderRadius($r('app.integer.contact_view_image_border_radius'))
            .autoResize(false)
              // 图片同步加载
            .syncLoad(this.imageSyncLoad ? true : false)

          // // 红点消息大于0条时渲染红点
          // if (this.contactItem.unreadMsgCount > 0){
          //   Text(`${this.contactItem.unreadMsgCount}`)
          //     .borderRadius($r('app.integer.chat_view_unread_border_radius'))
          //     .width($r('app.integer.chat_view_unread_width'))
          //     .height($r('app.integer.chat_view_unread_height'))
          //     .backgroundColor($r('app.color.unread_msg'))
          //     .fontSize($r('app.integer.chat_view_unread_font_size'))
          //     .textAlign(TextAlign.Center)
          //     .fontColor(Color.White)
          //     .margin({ top: $r('app.integer.chat_view_unread_margin_top'), right: $r('app.integer.chat_view_unread_margin_right') })
          // }
        }
      }
      .layoutWeight(1)
      .padding({ right: $r('app.integer.contact_view_col_padding_right') })

      // 对方用户名
      Column() {
        Text(this.contactItem.user.userName)
          .fontColor(Color.Black)
          .fontSize($r('app.integer.contact_view_user_name_font_size'))
          .margin({ bottom: $r('app.integer.contact_view_user_name_margin_bottom') })
        // Text(this.contactItem.lastMsg)
        //   .fontColor($r('app.color.last_msg'))
        //   .maxLines(1)
        //   .fontSize($r('app.integer.chat_view_user_msg_font_size'))
        //   .margin({ top: $r('app.integer.chat_view_user_msg_margin_top') })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(5)

      // TODO-联系人: 同意/拒绝按钮

      // // 最后一条消息时间
      // Column() {
      //   Text(this.contactItem.lastTime)
      //     .width($r('app.integer.chat_view_time_width'))
      //     .fontColor($r('app.color.last_msg'))
      //     .textAlign(TextAlign.End)
      //     .maxLines(1)
      //     .fontSize($r('app.integer.chat_view_time_font_size'))
      //     .margin({ right: $r('app.integer.chat_view_time_margin_right'), bottom: $r('app.integer.chat_view_time_margin_bottom') })
      // }
      // .padding({ left: $r('app.integer.chat_view_time_col_padding_left') })
      // .alignItems(HorizontalAlign.End)
      // .layoutWeight(1)
    }
    .width($r('app.string.layout_100'))
    .height($r('app.integer.contact_view_row_height'))
    .padding({ left: $r('app.integer.contact_view_row_padding_left'), right: $r('app.integer.contact_view_row_padding_right'), top: $r('app.integer.contact_view_row_padding_top'), bottom: $r('app.integer.contact_view_row_padding_bottom') })
  }
}