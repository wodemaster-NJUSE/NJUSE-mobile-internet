import router from '@ohos.router'
import url from '@ohos.url'
import { CommonConstants } from '../common/constants/CommonConstants'

@Entry
@Component
export struct SettingDetailView {
  // 标题
  title = null
  // 文本内容，即提示
  inputPlaceholder = null
  // 最大输入长度
  maxInputLength = null
  // 点击保存后，与后端交互的 URL
  pushUrl = null

  returnValue : string


  build() {
    Column() {
      // 顶层栏
      Row() {
        // 左箭头返回图标
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({
            left: $r('app.float.setting_page_padding'),
            right: $r('app.float.image_margin_right')
          })
          .onClick(() => {
            router.back();
          })

        // 标题
        Text(this.title)
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
          .layoutWeight(1)

        // 暂存修改
        Button("确定")
          .fontSize($r('app.float.setting_detail_view_font_size'))
          .backgroundColor($r('app.color.setting_detail_view_save_button'))
          .margin({
            right : $r('app.float.setting_detail_view_save_margin')
          })
          .onClick(() => {
            router.back({
              url: CommonConstants.SETTINGS_PAGE_URL,
              params: {
                newTextValue: this.returnValue
              }
            })
          })
          // todo 对前端数据的修改
          // todo 与后端的通信
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))

      // 输入框
      TextInput({placeholder : this.inputPlaceholder})
        .backgroundColor($r('app.color.setting_text_background'))
        .width(CommonConstants.NINETY_WIDTH_PERCENT)
        .maxLength(this.maxInputLength)
        .onChange((value : string) => this.returnValue = value)
      // 下划线
      Row()
        .width(CommonConstants.NINETY_WIDTH_PERCENT)
        .backgroundColor($r('app.color.setting_detail_view_save_button'))
        .height('1')
    }
  }
}