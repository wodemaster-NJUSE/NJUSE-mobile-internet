import Logger from '../utils/Logger';
import { ContactModel } from '../viewmodel/ContactBase';
import router from '@ohos.router';
import PageConstants from '../utils/PageConstants';

const TAG: string = 'ContactsList_ContactsView';

/**
 * 可复用且优化布局的联系人页面组件
 */
// @Reusable
@Component
export struct ReusableOptLayoutContactsView {
  @State contactItem: ContactModel = new ContactModel('', '', '');

  aboutToReuse(params: Record<string, Object>): void {
    this.contactItem = params.contactItem as ContactModel;
    Logger.info(TAG, 'aboutToReuse=' + this.contactItem.toString());
  }

  build() {
    OptLayoutContactsView({ contactItem: this.contactItem });
  }
}

/**
 * 优化布局的联系人页面组件
 */
@Preview
@Component
export struct OptLayoutContactsView {
  private contactItem: ContactModel = new ContactModel('', '', '');
  @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
    RelativeContainer() {
      Image(this.contactItem.userImage)
        .width($r('app.integer.opt_layout_contact_view_profile_picture_width'))
        .height($r('app.integer.opt_layout_contact_view_profile_picture_height'))
        .borderRadius($r('app.integer.opt_layout_contact_view_profile_picture_radius'))
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .syncLoad(this.imageSyncLoad ? true : false)
        .id("figure")

      // if (this.contactItem.unreadMsgCount > 0) { // 红点消息大于0条时渲染红点
      //   Row() {
      //     Text(`${this.contactItem.unreadMsgCount}`)
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
      //   .margin({ top: $r('app.integer.layout_minus_8'), left: $r('app.integer.layout_24') })
      //   .constraintSize({minWidth: $r('app.integer.opt_layout_chat_view_red_dot_container_width')})
      //   .height($r('app.integer.opt_layout_chat_view_red_dot_container_height'))
      //   .backgroundColor(Color.White)
      //   .alignRules({
      //     top: { anchor: '__container__', align: VerticalAlign.Top },
      //     left: { anchor: '__container__', align: HorizontalAlign.Start }
      //   })
      //   .opacity(this.contactItem.unreadMsgCount > 0 ? 1 : 0)
      //   .id('badge')
      // }

      Text(this.contactItem.userName)
        .fontColor($r('app.color.top_bar_font_color'))
        .fontSize($r('app.integer.opt_layout_contact_view_user_name_font_size'))
        .lineHeight($r('app.integer.layout_22'))
          // .font({ weight: 450 })
        .fontWeight(450)
        .margin({ top: $r('app.integer.layout_0'), left: $r('app.integer.contact_view_row_height') })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .id('user')

      // Text(this.contactItem.lastTime)
      //   .fontSize($r('app.integer.opt_layout_chat_view_item_padding_top'))
      //   .fontColor($r('app.string.search_inline_border_color'))
      //   .maxLines(1)
      //   .textAlign(TextAlign.End)
      //   .margin({ top: $r('app.integer.layout_0'), right: $r('app.integer.layout_0') })
      //   .alignRules({
      //     top: { anchor: '__container__', align: VerticalAlign.Top },
      //     right: { anchor: '__container__', align: HorizontalAlign.End }
      //   })
      //   .id('time')
      // Text(this.contactItem.lastMsg)
      //   .fontColor($r('app.string.search_inline_border_color'))
      //   .fontSize($r('app.integer.text_font_14'))
      //   .lineHeight($r('app.integer.layout_19'))
      //   .maxLines(1)
      //   .margin({ top: $r('app.integer.layout_24'), left: $r('app.integer.chat_view_row_height') })
      //   .alignRules({
      //     top: { anchor: '__container__', align: VerticalAlign.Top },
      //     left: { anchor: '__container__', align: HorizontalAlign.Start }
      //   })
      //   .id('msg')
    }
    .width($r('app.string.layout_100_percent'))
    .height($r('app.integer.opt_layout_contact_view_item_height'))
    .backgroundColor(Color.White)
    .padding({
      left: $r('app.integer.opt_layout_contact_view_item_padding_left'),
      right: $r('app.integer.opt_layout_contact_view_item_padding_right'),
      top: $r('app.integer.opt_layout_contact_view_item_padding_top'),
      bottom: $r('app.integer.opt_layout_contact_view_item_padding_bottom')
    })
    // TODO-联系人：跳转到好友设置界面
    // .onClick(() => {
    //   router.pushUrl({
    //     url: PageConstants.DETAIL_PAGE,
    //     params: {
    //       chatName: this.contactItem.user.userName,
    //       chatId: this.contactItem.user.userId,
    //       chatImg: this.contactItem.user.userImage,
    //       lastMsg: this.contactItem.lastMsg
    //     }
    //   }, (err) => {
    //     if (err) {
    //       Logger.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
    //       return;
    //     }
    //     Logger.info('pushUrl success');
    //   })
    // })
  }
}