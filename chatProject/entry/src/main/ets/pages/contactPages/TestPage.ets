import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { ChatContact, FriendMoment } from '../../viewmodel/MsgBase';

@Entry
@Component
struct OneMoment {
  private moment: FriendMoment = new FriendMoment('1', new ChatContact('2', 'Milo'),
    '我的说说', '2023/06/21 19:20', ['3','4'], '', '');
  @State imageListMinLength: number = 2;
  @State liked: boolean = false; // 是否点赞

  build() {
    Column() {
      Row() {
        // 头像
        Image($r('app.media.profile_photo_3')) //--
          .id('userImage')
          .autoResize(false)
          .width($r('app.integer.friendMomentsPage_user_image_width'))
          .height($r('app.integer.friendMomentsPage_user_image_height'))
          .borderRadius($r('app.integer.friendMomentsPage_user_image_border_radius'))
        Column() {
          // Row() {
          //   // 用户名
          //   Text(this.moment.user.userName)
          //     .fontSize($r('app.integer.friendMomentsPage_useName_fontSize'))
          //     .fontColor($r('app.color.title_font_color'))
          //     .lineHeight($r('app.integer.friendMomentsPage_useName_line_height'))
          //     .fontFamily($r('app.string.harmony_hei_ti'))
          //     .fontWeight(FontWeight.Medium)
          //
          //   // 时间
          //   Text(this.moment.time)
          //     .fontSize(12)
          //     .fontColor($r('app.color.title_font_color'))
          //     .lineHeight($r('app.integer.friendMomentsPage_useName_line_height'))
          //     .fontFamily($r('app.string.harmony_hei_ti'))
          //     .fontWeight(FontWeight.Normal)
          //     .margin({left: 20})
          // }
          // .width('100%')
          // .height(22)
          // .justifyContent(FlexAlign.Start)

          Text(this.moment.user.userName)
            .fontSize($r('app.integer.friendMomentsPage_useName_fontSize'))
            .fontColor($r('app.color.title_font_color'))
            .lineHeight($r('app.integer.friendMomentsPage_useName_line_height'))
            .fontFamily($r('app.string.harmony_hei_ti'))
            .fontWeight(FontWeight.Medium)

          Text(this.moment.time)
            .fontSize(12)
            .fontColor(Color.Gray)
            .lineHeight(22)
            .opacity($r('app.float.opacity_zero_point_six'))
            .fontFamily($r('app.string.harmony_hei_ti'))
            .margin({ top: 0})
        }
        .margin({ left: $r('app.integer.friendMomentsPage_user_col_margin_left') })
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width($r('app.string.layout_100'))
      .constraintSize({ minHeight: $r('app.integer.friendMomentsPage_oneMoment_height') })
      .padding({
        left: $r('app.integer.friendMomentsPage_row_padding_left'),
        right: $r('app.integer.friendMomentsPage_row_padding_right'),
        top: $r('app.integer.friendMomentsPage_row_padding_top'),
        bottom: $r('app.integer.friendMomentsPage_row_padding_bottom')
      })

      Row () {
        Text('sdfvsdvsdhsbshcbdshfbsdkfvjksbhdvkjsdbvkbsdhvksdhbvhkdsbvskhdbvksbdhvbskdhvbskhbvskf')
          .fontSize($r('app.integer.friendMomentsPage_userText_fontSize'))
          .fontColor(Color.Black)
          .lineHeight($r('app.integer.friendMomentsPage_userText_line_height'))
          // .opacity($r('app.float.opacity_zero_point_six'))
          .margin({ top: $r('app.integer.friendMomentsPage_userText_margin_top') })
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .padding({
        left: 60,
        right: 60
      })

      Column() {
        if (this.moment.imageList.length) {
          if (this.moment.imageList.length >= this.imageListMinLength) {
            GridRow({ columns: 3, gutter: $r('app.integer.friendMomentsPage_grid_gap') }) {
              ForEach(this.moment.imageList, (image: string, index?: number) => {
                GridCol() {
                  Image($r('app.media.profilePicture01')) //--
                    .id(`${index}`)
                    .width($r('app.integer.friendMomentsPage_image_width'))
                    .height($r('app.integer.friendMomentsPage_image_height'))
                    .borderRadius($r('app.integer.friendMomentsPage_image_radius'))
                    .onClick(() => {
                      router.pushUrl({
                        url: CommonConstants.FULL_IMAGE_PAGE_URL,
                        params: {
                          resourceUrl: JSON.stringify(this.moment.imageList),
                          isMedia: false,
                          imageIndex: index,
                          isMultipleImages: true
                        }
                      })
                    })
                }
              }, (image: string) => image)
            }
            .width($r('app.integer.friendMomentsPage_grid_height'))
          }
          else {
            Image($r('app.media.icon')) //--
              .id('singleImage')
              .width($r('app.integer.friendMomentsPage_single_image_width'))
              .height($r('app.integer.friendMomentsPage_single_image_height'))
              .borderRadius($r('app.integer.friendMomentsPage_single_image_radius'))
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/FullImagePage',
                  params: {
                    resourceUrl: this.moment.imageList[0],
                    isMedia: false
                  }
                })
              })
          }
        }
        else {
          Stack({ alignContent: Alignment.Center }) {
            Image(this.moment.mediaPreview)
              .width($r('app.integer.friendMomentsPage_single_video_width'))
              .height($r('app.integer.friendMomentsPage_single_video_height'))
              .borderRadius($r('app.integer.friendMomentsPage_single_video_radius'))
            Image($r('app.media.play'))
              .width($r('app.integer.friendMomentsPage_icon_play_width'))
              .height($r('app.integer.friendMomentsPage_icon_play_height'))
          }
          .width($r('app.integer.friendMomentsPage_single_video_width'))
          .height($r('app.integer.friendMomentsPage_single_video_height'))
          .id('videoComponent')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/FullImagePage',
              params: {
                resourceUrl: this.moment.media,
                isMedia: true
              }
            })
          })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .width($r('app.string.layout_100'))
      .padding({
        left: $r('app.integer.friendMomentsPage_image_group_padding_left'),
        right: $r('app.integer.friendMomentsPage_image_group_padding_right')
      })

      Row() {
        Row() {
          // MomentHandler({
          //   imageStr: $r('app.media.ic_share'),
          //   text: $r('app.string.friendMomentsPage_share')
          // })
          MomentHandler({
            imageStr: this.liked ? $r('app.media.ic_thumbsup_pre') : $r('app.media.ic_thumbsup'),
            text: $r('app.string.friendMomentsPage_thumbsup')
          })
            .onClick(() => {
              this.liked = !this.liked
              //TODO: 在这里更新点赞数
            })
          // MomentHandler({
          //   imageStr: $r('app.media.ic_message'),
          //   text: $r('app.string.friendMomentsPage_message')
          // })
          //   .margin({ left: $r('app.integer.friendMomentsPage_message_margin_left') })
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width($r('app.string.layout_100'))
      .margin({
        top: $r('app.integer.friendMomentsPage_handler_margin_top'),
        bottom: $r('app.integer.friendMomentsPage_handler_margin_bottom')
      })
      .padding({
        left: $r('app.integer.friendMomentsPage_handler_padding_left'),
        right: $r('app.integer.friendMomentsPage_handler_padding_right')
      })

    }
    .width($r('app.string.layout_100'))
  }
}

@Component
struct MomentHandler {
  @Prop imageStr: Resource = $r('app.media.ic_share');
  private text: string | Resource = '';

  build() {
    Row() {
      Image(this.imageStr)
        .height($r('app.integer.friendMomentsPage_handler_icon_height'))
        .width($r('app.integer.friendMomentsPage_handler_icon_width'))
        .objectFit(ImageFit.Contain)
        .autoResize(false)
      Text(this.text)
        .fontSize($r('app.integer.friendMomentsPage_handler_text_font_size'))
        .fontColor($r('app.color.title_font_color'))
        .fontFamily($r('app.string.harmony_hei_ti'))
        .opacity($r('app.float.opacity_zero_point_six'))
        .margin({ left: $r('app.integer.layout_5') })
    }
    .alignItems(VerticalAlign.Center)
  }
}