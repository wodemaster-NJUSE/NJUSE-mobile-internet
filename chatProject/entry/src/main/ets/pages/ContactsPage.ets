import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import { ContactsListDisplayView } from './contactPages/ContactsListPage';

@Entry
@Component
export struct ContactsPage {
  build() {
    Column() {
      this.TopBar()

      List() {
        ListItem() {
          // 设置项组件
          this.ContactSettingItemView()
        }
        .backgroundColor($r('app.color.contacts_page_new_friend'))
        .borderRadius($r('app.integer.setting_menu_border_radius'))
        .height($r('app.integer.setting_other_menu_list_height'))
        .onClick(() => {
          router.pushUrl({ url: CommonConstants.NEW_FRIENDS_PAGE_URL })
        })
      }
      .padding({ left: $r('app.integer.setting_padding_left'), right: $r('app.integer.setting_padding_left') })
      .layoutWeight(1)
      .margin({ top: $r('app.integer.discovery_list_margin_top') })
      .width($r('app.string.layout_100'))
      .height($r('app.string.layout_100'))
      .backgroundColor('#ffffff')

      ContactsListDisplayView()
    }
    .width('100%')
    .backgroundColor($r('app.color.contacts_page_background'))
  }

  // 顶部导航栏
  @Builder TopBar() {
    Stack({ alignContent: Alignment.End }) {
      Text('联系人')
        .fontSize($r('app.integer.top_bar_font_size'))
        .fontColor($r('app.color.top_bar_font_color'))
        .fontWeight(FontWeight.Bold)
        .height($r('app.integer.top_bar_text_height'))
        .width($r('app.string.layout_100'))
        .padding({ left: $r('app.integer.top_bar_text_padding_left') })
        .textAlign(TextAlign.Start)

      // // 处理好友申请按钮(图片未选)
      // Stack() {
      //   Image($r('app.media.add'))
      //     .height($r('app.integer.top_bar_settings_button_image_height'))
      //     .width($r('app.integer.top_bar_settings_button_image_width'))
      // }
      // .height($r('app.integer.top_bar_height'))
      // .width($r('app.integer.top_bar_settings_button_width'))
      // .padding({
      //   right: $r('app.integer.top_bar_process_application_button_padding_right')
      // })
      // .onClick(() => {
      //   router.pushUrl({
      //     url: CommonConstants.ADD_FRIEND_PAGE_URL
      //   })
      // })

      // 添加好友按钮
      Stack() {
        Image($r('app.media.add'))
          .height($r('app.integer.top_bar_settings_button_image_height'))
          .width($r('app.integer.top_bar_settings_button_image_width'))
      }
      .height($r('app.integer.top_bar_height'))
      .width($r('app.integer.top_bar_settings_button_width'))
      .padding({
        right: $r('app.integer.top_bar_settings_button_padding_right')
      })
      .onClick(() => {
        router.pushUrl({
          url: CommonConstants.ADD_FRIEND_PAGE_URL
        })
      })
    }
    .backgroundColor($r('app.color.top_bar_background_color'))
    .height($r('app.integer.top_bar_height'))
    .width($r('app.string.layout_100'))
  }

  // '新的朋友'列表项
  @Builder ContactSettingItemView() {
    Row() {
      Row() {
        Image($r('app.media.contacts_'))
          .width($r('app.integer.setting_menu_width'))
          .height($r('app.integer.setting_menu_width'))
          .objectFit(ImageFit.Contain)
        Text('新的朋友')
          .fontSize($r('app.integer.setting_menu_font_size'))
          .fontColor($r('app.color.setting_text_color'))
          .margin({ left: $r('app.integer.setting_menu_margin_left') })
          .layoutWeight(1)
          .lineHeight($r('app.integer.setting_menu_width'))
        Image($r('app.media.right_arrow'))
          .height($r('app.integer.setting_menu_arrow_height'))
          .width($r('app.integer.setting_menu_arrow_width'))
          .align(Alignment.End)
          .opacity($r('app.float.setting_menu_arrow_opacity'))
          .objectFit(ImageFit.Contain)
      }
      .width($r('app.string.layout_100'))
      .height($r('app.integer.settingPage_menu_height'))
      .padding({
        left: $r('app.integer.setting_menu_padding_left'),
        right: $r('app.integer.setting_menu_padding_left')
      })
      .alignItems(VerticalAlign.Center)
    }
    .width($r('app.string.layout_100'))
    .height($r('app.integer.settingPage_menu_height'))
    .alignSelf(ItemAlign.Center)
  }
}