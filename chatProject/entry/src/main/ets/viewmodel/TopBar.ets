import { CommonConstants } from '../common/constants/CommonConstants';
import router from '@ohos.router';

// 右上角齿轮按钮的ID
const ID_SETTING_BUTTON: string = "settingBtn";
@Preview
@Component
export struct TopBar {

  build() {
    Stack({ alignContent: Alignment.End }) {
      Text($r('app.string.chat'))
        .fontSize($r('app.integer.top_bar_font_size'))
        .fontColor($r('app.color.top_bar_font_color'))
        .fontWeight(FontWeight.Bold)
        .height($r('app.integer.top_bar_text_height'))
        .width($r('app.string.layout_100'))
        .padding({ left: $r('app.integer.top_bar_text_padding_left') })
        .textAlign(TextAlign.Start)

      Stack() {
        Image($r('app.media.settings'))
          .height($r('app.integer.top_bar_settings_button_image_height'))
          .width($r('app.integer.top_bar_settings_button_image_width'))
      }
        .id(ID_SETTING_BUTTON)
        .height($r('app.integer.top_bar_height'))
        .width($r('app.integer.top_bar_settings_button_width'))
        .padding({
          right: $r('app.integer.top_bar_settings_button_padding_right')
        })
        .onClick(() => {
          router.pushUrl({
            url: CommonConstants.SETTINGS_PAGE_URL
          })
        })
    }
    .margin({ top: '12vp' })
    .backgroundColor($r('app.color.top_bar_background_color'))
    .height($r('app.integer.top_bar_height'))
    .width($r('app.string.layout_100'))
  }
}