import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { CommonConstants } from '../../common/constants/CommonConstants';

@Entry
@Component
export struct myFriendDetailPage {
  private params = router.getParams() as Record<string, Object>;
  chatId: number = this.params.chatId as number;
  chatName: string | Resource = this.params.chatName as string | Resource;
  chatImg: string | Resource = this.params.chatImg as string | Resource;
  lastMsg: string | Resource = this.params.lastMsg as string | Resource;
  signature: string = '# 这是一条签名'
  gender : string = '男'


  build() {
    Column() {
      this.TopBar()

      this.FriendMsgList()

      Row() {
        // 保存修改按钮
        Button('发消息', {type: ButtonType.Normal, stateEffect: true})
          .borderRadius(8)
          .fontSize(18)
          .backgroundColor('#317aff')
          .width('45%')
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

        // 退出登录按钮
        Button('删除好友', {type: ButtonType.Normal, stateEffect: true})
          .borderRadius(8)
          .backgroundColor('0x317aff')
          .width('45%')
          .backgroundColor('#FFFA0404')
          .fontSize(18)
          .onClick(() => {
            // TODO-退出登录
          })
      }
      .width('90%')
      .height('48vp')
      .margin({top: 18})
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#FFEAEAEA")
  }

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
        .fontSize(20)
        .fontColor('#182431')
        .width('40%')
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

  @Builder FriendMsgList() {
    List() {
      // 头像
      ListItem() {
        Row() {
          Text('头像')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .layoutWeight(1)
            .margin({left: 12})

          Image(this.chatImg)
            .height(54)
            .width(54)
            .borderRadius(27)
            .margin({right: 20})
            .align(Alignment.End)
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .borderRadius(8)
    }
    .width('90%')
    .height(80)


    List() {
      // 用户名
      ListItem() {
        Row() {
          Text('用户名')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .width('25%')
            .margin({left: 12})

          Text(this.chatName)
            .fontSize(18)
            .textAlign(TextAlign.Start)
            .height('100%')
            .width('75%')
          // TextInput({placeholder : this.chatName})
          //   .placeholderFont({size : 18})
          //   .placeholderColor(Color.Black)
          //   .height('100%')
          //   .width('80%')
          //   .borderRadius(0)
          //   .backgroundColor(Color.White)
          //   .onChange((value: string) => {
          //     this.userName = value;
          //     this.isChanged = true;
          //   })
        }
      }
      .width('100%')
      .height(46)
      .backgroundColor(Color.White)
      .borderRadius({
        topLeft : 8,
        topRight : 8
      })

      // 性别
      ListItem() {
        Row() {
          Text('性别')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .width('25%')
            .margin({left: 12})

          Text(this.gender)
            .fontSize(18)
            .textAlign(TextAlign.Start)
            .height('100%')
            .width('75%')
        }
      }
      .width('100%')
      .height(46)
      .backgroundColor(Color.White)

      // 签名
      ListItem() {
        Row() {
          Text('签名')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .width('25%')
            .margin({left: 12})

          Text(this.signature)
            .fontSize(18)
            .textAlign(TextAlign.Start)
            .maxLines(1)
            .height('100%')
            .width('75%')

          // TextInput({placeholder : this.signature})
          //   .placeholderFont({size : 18})
          //   .placeholderColor(Color.Black)
          //   .height('100%')
          //   .width('80%')
          //   .borderRadius(0)
          //   .backgroundColor(Color.White)
          //   .onChange((value: string) => {
          //     this.signature = value;
          //     this.isChanged = true;
          //   })
        }
      }
      .width('100%')
      .height(46)
      .backgroundColor(Color.White)
      .borderRadius({
        bottomLeft: 8,
        bottomRight: 8
      })
    }
    .width('90%')
    .height('140')
    .divider({
      strokeWidth: '4px',
      startMargin: 6,
      endMargin: 6,
      color: "#FFEAEAEA"
    })
    .margin({
      top: 12
    })

    // 空间
    List() {
      ListItem() {
        Row() {
          Text('好友空间')
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .height('100%')
            .layoutWeight(1)
            .margin({left: 12})

          Image($r('app.media.right_arrow'))
            .height(18)
            .width(18)
            .objectFit(ImageFit.Contain)
            .margin({right: 12})
            .align(Alignment.End)
        }
      }
      .width('100%')
      .height(46)
      .backgroundColor(Color.White)
      .borderRadius(8)
      .onClick(() => {
        // TODO-进入好友空间
      })
    }
    .width('90%')
    .height(50)
    .divider({
      strokeWidth: '4px',
      startMargin: 6,
      endMargin: 6,
      color: "#FFEAEAEA"
    })
    .margin({
      top: 12
    })
  }
}