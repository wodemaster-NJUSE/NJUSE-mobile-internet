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

      Button('同意', {type: ButtonType.Normal, stateEffect: true})
        .borderRadius(8)
        .fontSize(14)
        .fontColor(Color.Black)
        .backgroundColor(Color.White)
        .borderWidth(1)
        .borderColor(Color.Gray)
        .width(62)
        .height(30)
        .margin({
          top: 17,
          right: 32
        })
        .alignRules({
          top: {anchor: '__container__', align: VerticalAlign.Top},
          right: {anchor: '__container__', align: HorizontalAlign.End}
        })
        .onClick(() => {
          // TODO-联系人:同意好友申请
        })
        .id('button')


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