import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import {ContactsComponent} from '../view/ContactsComponent';

@Entry
@Component
export struct ContactsPage {
  build() {
    Column() {
      this.TopBar()
      // ContactsComponent()
    }
    .width('100%')
    .backgroundColor($r('app.color.contacts_page_background'))
  }

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
}