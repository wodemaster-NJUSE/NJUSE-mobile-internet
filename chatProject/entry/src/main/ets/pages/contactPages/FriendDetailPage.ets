import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';

@Entry
@Component
export struct FriendDetailPage {
  private params = router.getParams() as Record<string, Object>;
  chatId: number = this.params.chatId as number;
  chatName: string | Resource = this.params.chatName as string | Resource;
  chatImg: string | Resource = this.params.chatImg as string | Resource;
  lastMsg: string | Resource = this.params.lastMsg as string | Resource;

  build() {
    Column() {
      this.TopBar()
      this.MessageList()

      Row() {
        // 发消息按钮
        Button('发消息', {type: ButtonType.Normal, stateEffect: true})
            .borderRadius(8)
            .fontSize(18)
            .backgroundColor('#317aff')
            .width(110)
            .onClick(() => {
              router.pushUrl({
                url: CommonConstants.DETAIL_PAGE_URL,
                params: {
                  chatName: this.chatName,
                  chatId: this.chatId,
                  chatImg: this.chatImg,
                  lastMsg: this.lastMsg
                }
              }, (err) => {
                if (err) {
                  console.error(`pushUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
                console.info('pushUrl success');
              })
            })

        // 删除好友按钮
        Button('删除好友', {type: ButtonType.Normal, stateEffect: true})
          .borderRadius(8)
          .backgroundColor('0x317aff')
          .width(110)
          .backgroundColor('#FFFA0404')
          .fontSize(18)
          .onClick(() => {
            // TODO-联系人: 删除好友实现
          //   @ohos.arkui.advanced.Dialog（弹出框）
            // or promptAction.showDialog
          })
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height('48vp')
      .backgroundColor('#f1f3f5')
      .justifyContent(FlexAlign.SpaceAround)
    }
    .width($r('app.string.layout_100'))
    .height($r('app.string.layout_100'))
    .backgroundColor($r("app.color.setting_background"))
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

      Text('好友信息')
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

  // 好友信息列表
  @Builder MessageList() {
    List({ space: 2 }) {
      ListItem() {
        settingImageItem({
          title : "头像",
          imageContent : this.chatImg,
        })
      }
      ListItem() {
        settingTextItem({
          title : "用户名",
          textContent : this.chatName,
        })
      }
      ListItem() {
        settingTextItem({
          title : "个性签名",
          textContent : "# 这是个性签名~",
        })
      }
      ListItem() {
        settingTextItem({
          title : "空间",
          textContent : '进入TA的空间探索吧',
        })
      }.onClick(() => {
        // TODO-联系人: 进入好友的空间
        // router.pushUrl({
        //   url: this.pushUrl
        // })
      })
      // ListItem() {
      //   settingTextItem({
      //     title : "签名",
      //     textContent : $signature,
      //   })
      // }
      // ListItem() {
      //   settingTextItem({
      //     title : "性别",
      //     textContent : $gender,
      //   })
      // }
    }
    .width($r('app.string.layout_100'))
    .margin({bottom : 12})
  }


}

// 单个图片设置项
@Component
struct settingImageItem {
  // 标题
  title : string

  // 图片内容
  imageContent : string | Resource

  build() {
    Row() {
      // 设置项
      Text(this.title)
        .fontSize($r('app.integer.setting_page_attribute_font_size'))
        .layoutWeight(2)
      // 设置项的当前图片内容
      Image(this.imageContent)
        .align(Alignment.End)
        .opacity($r('app.float.setting_menu_arrow_opacity'))
        .objectFit(ImageFit.Contain)
        .size({
          height : '48vp',
          width : '48vp'
        })
    }
    .padding({
      left : $r('app.float.setting_page_padding'),
      right : $r('app.float.setting_page_padding'),
      top : $r('app.float.setting_page_padding'),
      bottom : $r('app.float.setting_page_padding'),
    })
    .width($r('app.string.layout_100'))
    .backgroundColor($r("app.color.setting_front"))
  }
}

// 单个文本设置项
@Component
struct settingTextItem {
  // 标题
  title : string

  // 文本内容
  textContent : string | Resource

  build() {
    Row() {
      // 设置项
      Text(this.title)
        .fontSize($r('app.integer.setting_page_attribute_font_size'))
        .layoutWeight(2)
      // 设置项的当前文字内容
      Text(this.textContent)
        .fontSize($r('app.integer.setting_page_content_font_size'))
        .layoutWeight(8)
        .fontColor($r('app.color.setting_content'))
        .textAlign(TextAlign.End)
    }
    .padding({
      left : $r('app.float.setting_page_padding'),
      right : $r('app.float.setting_page_padding'),
      top : $r('app.float.setting_page_padding'),
      bottom : $r('app.float.setting_page_padding'),
    })
    .width($r('app.string.layout_100'))
    .backgroundColor($r("app.color.setting_front"))
  }
}