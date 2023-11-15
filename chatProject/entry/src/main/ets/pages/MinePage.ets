import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import MinePageContentComponent from '../view/MinePageContentComponent';

/**
 * Personal Center page, displaying personal information and app-related settings.
 */
@Entry
@Component
struct MinePage {
  build() {
    Column() {
      this.Title()

      Scroll(){
        GridRow({
          columns: {
            sm: CommonConstants.GRID_ROW_SM,
            md: CommonConstants.GRID_ROW_MD,
            lg: CommonConstants.GRID_ROW_LG
          },
          gutter: { x: CommonConstants.GUTTER_X },
          breakpoints: { value: CommonConstants.BREAK_POINT }
        }) {
          GridCol({
            span: {
              sm: CommonConstants.MINE_SPAN_SM,
              md: CommonConstants.MINE_SPAN_MD,
              lg: CommonConstants.MINE_SPAN_LG
            },
            offset: {
              lg: CommonConstants.OFFSET_LG
            }
          }) {
            Column(){
              Image($r('app.media.ic_user_profile'))
                .width($r('app.float.user_profile_image_width'))
                .height($r('app.float.user_profile_image_height'))
                .objectFit(ImageFit.Contain)

              Text($r('app.string.user_nickname'))
                .textAlign(TextAlign.Center)
                .fontWeight(CommonConstants.NICKNAME_FONT_WEIGHT)
                .fontSize($r('app.float.nickname_font_size'))
                .margin({ top: $r('app.float.nickname_margin_top') })

              MinePageContentComponent()
            }
            .width(CommonConstants.MINE_PAGE_WIDTH_PERCENT)
            .height(CommonConstants.MINE_PAGE_HEIGHT_PERCENT)
          }
        }
        .margin({
          left: $r('app.float.user_grid_row_margin'),
          right: $r('app.float.user_grid_row_margin')
        })
      }
      .margin({ top: $r('app.float.profile_image_margin_top') })
    }
    .alignItems(HorizontalAlign.Center)
    .backgroundColor($r('app.color.login_page_background'))
  }

   @Builder Title() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: $r('app.float.image_margin_left'),
          right: $r('app.float.image_margin_right')
        })
        .onClick(() => {
          router.back();
        })

      Text($r('app.string.mine_page_title'))
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
  }
}