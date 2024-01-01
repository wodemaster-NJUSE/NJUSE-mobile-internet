import Logger from '../utils/Logger';
import { ChatContact } from '../viewmodel/MsgBase';
import { ChatModel} from '../viewmodel/MsgBase'
import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

const TAG: string = 'ContactsList_ContactsView';

/**
 * 可复用且优化布局的联系人页面组件
 */
// @Reusable
@Component
export struct ReusableContactsView {
  @State contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);

  aboutToReuse(params: Record<string, Object>): void {
    this.contactItem = params.contactItem as ChatModel;
    Logger.info(TAG, 'aboutToReuse=' + this.contactItem.toString());
  }

  build() {
    ContactsView({ contactItem: this.contactItem });
  }
}

/**
 * 优化布局的联系人页面组件
 */
@Preview
@Component
export struct ContactsView {
  private contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);
  @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
    RelativeContainer() {
      Image(this.contactItem.user.userImage)
        .width($r('app.integer.opt_layout_contact_view_profile_picture_width'))
        .height($r('app.integer.opt_layout_contact_view_profile_picture_height'))
        .borderRadius($r('app.integer.opt_layout_contact_view_profile_picture_radius'))
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

      Text(this.contactItem.user.userName)
        .fontColor($r('app.color.top_bar_font_color'))
        .fontSize($r('app.integer.opt_layout_contact_view_user_name_font_size'))
        .lineHeight($r('app.integer.layout_22'))
        .fontWeight(450)
        .margin({ top: $r('app.integer.layout_10'), left: $r('app.integer.contact_view_row_height') })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .id('user')


      Text('# 这是个性签名')
        .fontColor(Color.Gray)
        .fontSize($r('app.integer.text_font_14'))
        .lineHeight($r('app.integer.layout_19'))
        .maxLines(1)
        .margin({ top: $r('app.integer.layout_34'), left: 68 })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .id('msg')
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
    .onClick(() => {
      // 进入好友详情页
      router.pushUrl({
        url: CommonConstants.FRIEND_DETAIL_PAGE_URL,
        params: {
          chatName: this.contactItem.user.userName,
          chatId: this.contactItem.user.userId,
          chatImg: this.contactItem.user.userImage,
          lastMsg: this.contactItem.lastMsg
        }
      }, (err) => {
        if (err) {
          console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
          return;
        }
        console.info('pushUrl success');
      })
    })
  }
}