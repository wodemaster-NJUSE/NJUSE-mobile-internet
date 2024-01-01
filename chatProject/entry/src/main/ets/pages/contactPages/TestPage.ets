import router from '@ohos.router';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { ChatContact, ChatModel } from '../../viewmodel/MsgBase';

@Entry
@Component
@Preview
export struct NewFriendsView {
  private contactItem: ChatModel = new ChatModel(new ChatContact('', ''), '', '', 0);
  // @StorageLink('image_sync_load') imageSyncLoad: boolean | undefined = AppStorage.Get('image_sync_load');

  build() {
    Column() {
      this.TopBar()

      Column() {
        TextArea({placeholder:'分享新鲜事……'})
          .width('100%')
          .height(180)
          .borderRadius(0)
          .backgroundColor('#FFF3F3F3')
          .placeholderFont({
            size: 18
          })
          .margin({
            top: 12
          })
          .onChange((value: string) => {
            // this.keyboardStr = value;
          })

        //添加图片
        Text('选择照片')
          .textAlign(TextAlign.Center)
          .width(120)
          .fontSize(16)
          .fontColor(Color.White)
          .padding(10)
          .margin(20)
          .borderRadius(8)
          .backgroundColor('#FF90D1FD')
          .onClick(async () => {
            // this.pictures = await this.mediaHelper.selectPictures();
          })

      }
      .width('100%')
      .height(280)
      .backgroundColor('#FFF3F3F3')
      .margin({
        top: 12
      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor("#FFEAEAEA")
  }

  @Builder TopBar() {
    Row() {
      Text('取消')
        .height(40)
        .width(66)
        .textAlign(TextAlign.Center)
        .fontSize(20)
        .fontColor(Color.Black)
        .margin({
          left: 12
        })
        .onClick(() => {
          router.back()
        })

      Text('发表动态')
        .fontSize(20)
        .fontColor('#182431')
        .width(88)
        .height(40)
        .textAlign(TextAlign.Center)

      Text('发布')
        .width(66)
        .height(32)
        .textAlign(TextAlign.Center)
        .fontColor(Color.White)
        .fontSize(16)
        .backgroundColor('#FF6EC2FA')
        .borderRadius(4)
        .margin({
          right: 12
        })
        .onClick(() => {
          // TODO-发布动态
        })
    }
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .height($r('app.float.title_height'))
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFF3F3F3')
  }
}