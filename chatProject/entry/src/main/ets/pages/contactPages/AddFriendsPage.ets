import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import { UserEntity } from '../../stores/user';
import { ResponseResult } from '../../utils/http/HttpCore';
import { HttpManager } from '../../utils/http/HttpManager';
import { RequestMethod, RequestOptions } from '../../utils/http/RequestOptions';

@Entry
@Component
export struct AddFriendsPage {
  @State submitValue: string = globalThis.testUid;
  // 根据状态切换展示信息
  @State private searchState : number = 0;
  // '添加好友'按钮状态
  @State private send: boolean = false;

  uid = globalThis.UID

  @State user : UserEntity = new UserEntity();
  @State username : string = '';

  search_placeholder: string = '请输入您要搜索的UID'

  build() {
    Column() {
      this.TopBar()

      // 搜索框
      Text('submitValue:' + this.submitValue).fontSize(18).margin(15)
      Search({placeholder: this.search_placeholder})
        .searchButton('搜索')
        .width('90%')
        .height(40)
        .backgroundColor('#F5F5F5')
        .placeholderColor(Color.Gray)
        .placeholderFont({size: 14, weight: 400})
        .textFont({size: 14,weight: 400})
        .onSubmit((value: string) => {
          this.submitValue = value
          // TODO-联系人: 查询用户
          this.searchState = 1;
          this.send = false;

          const requestOptions: RequestOptions = {
                  url: "http://172.29.4.148:8080/v1/find?senderUid=" + this.uid + "&receiverUid=" + value,//
                  method: RequestMethod.GET,
                  header: {
                    'Content-Type': 'application/json'
                  },
                  // extraData: JSON.stringify({
                  //   uid : value
                  // })
                };
                // 调用HttpManager的request方法，发起POST请求
                HttpManager.getInstance().request<ResponseResult>(requestOptions)
                  .then((result) => {
                    console.info('csdcs');
                    // this.user.username = JSON.parse(JSON.stringify(result.data)).username;
                    // console.info("csdcs:" + this.user.username);

                    Object.assign(this.user, result.data);
                    this.username = this.user.username;
                    console.info("searchfind" + " " + this.user.username + " " + this.username); //输出
                  })
                  .catch((err) => {
                    console.error(JSON.stringify(err));
                  });
              }
        )
        .margin(20)

      if (this.searchState === 1) {
        RelativeContainer() {
          Image($r('app.media.profile_photo_3'))
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
              // .syncLoad(true)
            .id("figure")

          Text(this.username)
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

          if (!this.send) {
            Button('添加', {type: ButtonType.Normal, stateEffect: true})
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
                this.send = true;
                // TODO-联系人:发送好友申请

                const requestOptions: RequestOptions = {
                  url: "http://172.29.4.148:8080/v1/requestFriend",//
                  method: RequestMethod.POST,
                  header: {
                    'Content-Type': 'application/json'
                  },
                  extraData: JSON.stringify({
                    senderUid : this.uid,
                    receiverUid : this.user.uid
                  })
                };
                // 调用HttpManager的request方法，发起POST请求
                HttpManager.getInstance().request<ResponseResult>(requestOptions)
                  .then((result) => {
                    console.info('发送好友申请：' + JSON.stringify(result.data));//输出
                  })
                  .catch((err) => {
                    console.error(JSON.stringify(err));
                  });

              })
              .id('button')
          } else {
            Text('已发送')
              .fontSize(16)
              .fontColor(Color.Gray)
              .height(26)
              .margin({
                top: 17,
                right: 40
              })
              .alignRules({
                top: { anchor: '__container__', align: VerticalAlign.Top },
                right: {anchor: '__container__', align: HorizontalAlign.End}
              })
              .id('hasConsent')
          }
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
      }

    }
    .width('100%')
    .backgroundColor('#ffffff')

    // TODO-联系人: 展示搜索结果
  }

  // 顶部导航栏
  @Builder TopBar() {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: $r('app.float.image_margin_left'),
          right: $r('app.float.image_margin_right')
        })
        .onClick(() => {
          router.back()
        })

      Text('添加好友')
        .fontSize(26)
        .fontColor('#182431')
        .width('30%')
        .textAlign(TextAlign.Center)

      Text().width('24vp').margin({
        left: '16vp',
        right: '24vp'
      })
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
    .justifyContent(FlexAlign.SpaceBetween)
  }

  // 搜索到的用户信息
  @Builder SearchMessage() {
    RelativeContainer() {
      Image($r('app.media.profile_photo_3'))
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
        // .syncLoad(true)
        .id("figure")

      Text(this.user.username)
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

      if (!this.send) {
        Button('添加', {type: ButtonType.Normal, stateEffect: true})
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
            this.send = true;
            // TODO-联系人:发送好友申请

            const requestOptions: RequestOptions = {
              url: "http://172.29.4.148:8080/v1/find",//
              method: RequestMethod.POST,
              header: {
                'Content-Type': 'application/json'
              },
              extraData: JSON.stringify({
                senderUid : this.uid,
                receiverUid : this.user.uid
              })
            };
            // 调用HttpManager的request方法，发起POST请求
            HttpManager.getInstance().request<ResponseResult>(requestOptions)
              .then((result) => {
                console.info('发送好友申请：' + JSON.stringify(result.data));//输出
              })
              .catch((err) => {
                console.error(JSON.stringify(err));
              });

          })
          .id('button')
      } else {
        Text('已发送')
          .fontSize(16)
          .fontColor(Color.Gray)
          .height(26)
          .margin({
            top: 17,
            right: 40
          })
          .alignRules({
            top: { anchor: '__container__', align: VerticalAlign.Top },
            right: {anchor: '__container__', align: HorizontalAlign.End}
          })
          .id('hasConsent')
      }
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
  }

}