
import { MessageBase, ChatContact, TextMessage, ImageMessage, MessageBody, ChatDetailData } from '../../viewmodel/MsgBase';
import { getMessageListFromJSON } from '../../utils/DataFactory';
import router from '@ohos.router';
import { ImageTextMessage, FileMessage } from '../../viewmodel/MsgBase';
import image from '@ohos.multimedia.image';
import Constants from '../../utils/Constants';
import hiTraceMeter from '@ohos.hiTraceMeter';
import Want from '@ohos.app.ability.Want';
import Logger from '../../utils/Logger';
import fs from '@ohos.file.fs';

import { ShareDate, WantFileModel, WantModel } from '../../model/Want';
import { ChatItemView } from './ChatItemView';
import webSocket from '@ohos.net.webSocket';
import { RequestMethod, RequestOptions } from '../../utils/http/RequestOptions';
import { HttpManager } from '../../utils/http/HttpManager';
import { ResponseResult } from '../../utils/http/HttpCore';
import { CommonConstants } from '../../common/constants/CommonConstants';

const ABOUT_TO_APPEAR_TRACE: string = 'ChatDetailPage_AboutToAppear_HiTrace';
const ABOUT_TO_APPEAR_TRACE_ID: number = 1; // aboutToAppear 中使用的 taskId
const MAKE_DATA_LOCAL_TRACE: string = 'ChatDetailPage_MakeDataLocal_HiTrace';
const MAKE_DATA_LOCAL_TRACE_ID: number = 2; // makeDataLocal 中使用的 taskId
const STROKE_WIDTH: number = 2; // strokeWidth的宽度
const LAYOUT_WEIGHT: number = 1; // layoutWeight参数


@Preview
@Component
export struct ChatDetailPage {

  @StorageLink('keyboardHeight') keyboardHeight: number = 0;
  @State msgLength: number = 0;
  userMyself = new ChatContact('1', $r('app.string.myself'));// id,名称，头像可选
  userFriend = new ChatContact('2', $r('app.string.friend'));
  msg = new TextMessage($r('app.string.message1'));
  msgAnother = new TextMessage($r('app.string.message2'));
  todayDate = new Date();
  msgBody = new MessageBase('1', this.userMyself, this.userFriend, '', "1", this.todayDate.getSeconds().toString());

  @State keyboardStr: string = '';
  private chatDetailData = new ChatDetailData();// 聊天信息加载,要填充
  private scroller: Scroller = new Scroller();
  @State wantId: number = 0;
  @State userMyselfName: string = '';
  @State userFriendName: string = '';
  @State listHeight: number = 0;

  @State want: Want | undefined = undefined;
  wantParams: WantModel = new WantModel("src/main/resources/images/photo0.jpg", "111", 0);
  wantFileParams: WantFileModel = new WantFileModel();

  @State imageFile: image.PixelMap | undefined = undefined;
  @State imageSize: number = 90960;
  private params = router.getParams() as Record<string, Object>;
  chatId: number = this.params.chatId as number;// 朋友的uid
  chatName: string | Resource = this.params.chatName as string | Resource;
  chatImg: string | Resource = this.params.chatImg as string | Resource;
  lastMsg: string | Resource = this.params.lastMsg as string | Resource;
  time  = new Date();


  build() {

    Column() {
      // 顶部导航栏
      Row() {
        Row() {
          Image($r('app.media.ic_back'))//原为
            .id('returnBtn')
            .height(24)
            .width(24)
            .margin({
              left: 14
            })
            .onClick(() => {
              router.back();
            })

          Text(this.chatName)
            .fontSize($r('app.integer.opt_layout_chat_view_profile_picture_radius'))
            .lineHeight($r('app.integer.layout_28'))
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .margin({ left: $r('app.integer.search_font_size') })
        }
        .margin({ left: $r('app.integer.opt_layout_chat_view_item_padding_right') })

        Stack({ alignContent: Alignment.End }) {
          Image($r('app.media.chat_detail_more'))
            .height($r('app.integer.opt_layout_chat_view_item_padding_right'))
            .width($r('app.integer.opt_layout_chat_view_item_padding_right'))
            .margin({ right: $r('app.integer.opt_layout_chat_view_item_padding_right') })
        }
        .id('moreBtn')
      }
      .height($r('app.integer.search_outline_height'))
      .width($r('app.string.layout_100'))
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.SpaceBetween)

      List({ scroller: this.scroller, initialIndex: this.msgLength - 1 }) {
        LazyForEach(this.chatDetailData, (msg: MessageBase) => {
          ListItem() {
            ChatItemView({ msg: msg });
          }
        }, (msg: MessageBase) => msg.msgId)
      }
      .listDirection(Axis.Vertical)
      .divider({ strokeWidth: STROKE_WIDTH, color: $r('app.color.detail_divider') })
      .padding({
        left: $r('app.integer.layout_10'),
        right: $r('app.integer.layout_10'),
        bottom: $r('app.integer.layout_10')
      })
      .width($r('app.string.layout_100'))
      .layoutWeight(LAYOUT_WEIGHT)

      // 底部输入框
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        TextArea({ placeholder: '', text: this.keyboardStr })
          .id('bottomTextInput')
          .height(36)
          .layoutWeight(LAYOUT_WEIGHT)
          .borderRadius(2)
          .backgroundColor(Color.White)
          .margin({
            left: 12
          })
          .onChange((value: string) => {
            this.keyboardStr = value;
          })

        Image($r('app.media.input_emoji'))
          .id('chatExpression')
          .height(36)
          .width(36)
          .margin({ left: 10, right: 10  })
          .onClick(() => {// 设定图片url
            let imageStr = `/resources/images/photo${((this.chatId) % 50)}.jpg`;
            let msg = new ImageMessage(40, 50, imageStr);
            let msgBody = new MessageBase(this.chatDetailData.totalCount()
              .toString(), this.userMyself, this.userFriend, '', "2");
            this.chatDetailData.pushData(msgBody);
            this.msgLength = this.chatDetailData.totalCount();
            this.scroller.scrollToIndex(this.msgLength - 1);
          })

        Text('发送')
          .height(36)
          .width(62)
          .backgroundColor('#FF6EC2FA')
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .margin({ right: 10 })
          .onClick(() => {
            this.todayDate = new Date();
            let msg = new TextMessage(this.keyboardStr);
            let msgBody = new MessageBase(this.chatDetailData.totalCount()
              .toString(), this.userMyself, this.userFriend, msg, "1", this.todayDate.getSeconds().toString());
            this.chatDetailData.pushData(msgBody);
            this.msgLength = this.chatDetailData.totalCount();
            this.scroller.scrollToIndex(this.msgLength - 1);

            const requestOptions: RequestOptions = {// 发送一条message
              url: "http://172.29.4.148:8080/v2/sendMessage",
              method: RequestMethod.POST,
              header: {
                'Content-Type': 'application/json'
              },
              extraData:{
                "msgId":"1",
                "from":  {
                  "userId" : this.userMyself.userId,
                  "userName" : this.userMyself.userName,
                  "userImage": "null"
                },
                "to":  {
                  "userId" : this.userFriend.userId,
                  "userName" : this.userFriend.userName,
                  "userImage": this.userFriend.userImage
                },
                "msgBody": msgBody.toString(),
                "msgType": "1",
                "msgTime": this.todayDate.getSeconds().toString()
              }
            };

            //
            HttpManager.getInstance().request<ResponseResult>(requestOptions)
              .then((result) => {
                console.info("post_msg:start")
                if(result.code == '200') {
                  // 成功返回
                  console.info("post_msg:"+JSON.stringify(result.data)); //信息
                }
              })
              .catch((err) => {
                console.error("post_error" + err);
              });
            // // 使用websocket通信
            // let message : string =
            // "{"+
            //   "senderUid" + ":" +this.chatId.toString() + ","+
            //   //"receiverUid" + ":" +"1000001" + ","+ // 暂时写死uid
            //   "receiverUid" + ":" +this.chatId.toString() + ","+
            //   "message" + ":" +  this.keyboardStr + ","+
            //   "time" + ":" + this.time.toString()+
            // "}";
            // globalThis.WS.send(message, (err, value) => {
            //   if (!err) {
            //     // 成功发送一条消息就更新一次
            //     console.log("Message sent successfully");
            //
            //     const requestOptions: RequestOptions = {
            //       url: "http://172.29.4.148:8080/v2/sendMessage",//
            //       method: RequestMethod.POST,
            //       header: {
            //         'Content-Type': 'application/json'
            //       },
            //       extraData: JSON.stringify({
            //         MessageBase:msgBody
            //       })
            //     };
            //     // 调用HttpManager的request方法，发起POST请求
            //     HttpManager.getInstance().request<ResponseResult>(requestOptions)
            //       .then((result) => {
            //         console.info(JSON.stringify(result.data));//输出
            //       })
            //       .catch((err) => {
            //         console.error(JSON.stringify(err));
            //       });
            //   } else {
            //     console.log("Failed to send the message. Err:" + JSON.stringify(err));
            //   }
            // });


            this.keyboardStr = '';
          })
      }
      .backgroundColor('#FFF3F3F3')
      .width($r('app.string.layout_100'))
      .height(52)
    }
    .padding({ bottom: px2vp((this.keyboardHeight)) })
    .backgroundColor($r('app.color.detail_body_background'))
    .height($r('app.string.layout_100'))
  }

  async getWant() {
    // 文本、链接的参数处理
    this.want = AppStorage.Get('want');
    if (this.want?.parameters) {
      this.wantParams.srcImage = this.want.parameters.srcImg as string;
      this.wantParams.textContent = this.want.parameters.text as string;
      this.wantParams.senderId = this.want.parameters.kindId as number;
      this.wantId = this.wantParams.senderId;
    }
  }

  async onPageShow(){

    const requestOptions: RequestOptions = {// 发送一条message
      url: "http://172.29.4.148:8080/v2/getMessages?"+"ownerUid"+"="+globalThis.UID+"&"+"friendUid"+"="+this.chatId.toString(),
      method: RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      },
    };

    //
    HttpManager.getInstance().request<ResponseResult>(requestOptions)
      .then((result) => {
        if(result.code == '200') {
          // 成功返回
          console.info("get MessageList on page show" + JSON.stringify(result.data)); //输出
          // 表示成功
          Object.assign(this.chatDetailData.msgList, result.data) // 填充聊天信息
        }
      })
      .catch((err) => {
        console.error(JSON.stringify(err));
      });

  }





  async fdTransformPixelMap(): Promise<void> {
    try {
      if (this.want?.parameters === undefined) {
        return
      }

      let shareDate = this.want.parameters["keyFd"] as ShareDate;
      this.wantFileParams.fdImage = shareDate.value;
      let buffer = new ArrayBuffer(this.imageSize);
      let readOut = fs.readSync(this.wantFileParams.fdImage, buffer);
      Logger.info('fdTransformPixelMap: readOut---' + readOut);
      let imageSource: image.ImageSource | undefined = undefined;
      imageSource = image.createImageSource(buffer);
      let decodingOptions: image.DecodingOptions = {
        editable: true, // 是否可编辑
        desiredPixelFormat: 3 // 解码的像素格式
      };
      this.imageFile = await imageSource.createPixelMap(decodingOptions); // 通过图片解码参数创建PixelMap对象
    } catch (errorOut) {
      Logger.info('fdTransformPixelMap: errorOut ---' + errorOut);
    }
  }

  async convertResourceToString(resource: Resource) {
    let context = getContext(this);
    let manager = context.resourceManager;
    return await manager.getStringValue(resource.id);
  }

  // 设定本地聊天内容，假数据填充
  // async makeDataLocal() {
  //   hiTraceMeter.startTrace(MAKE_DATA_LOCAL_TRACE, MAKE_DATA_LOCAL_TRACE_ID);
  //   let chatDetailMsgList = await getMessageListFromJSON();
  //   let todayDate = new Date();
  //   let userMyself = new ChatContact('1', $r('app.string.myself'));
  //   let userFriend = new ChatContact('2', this.chatName, this.chatImg);
  //   let sum = 0;
  //   // 循环遍历本地数据，通过取模的方式选择文本数据或者图片数据
  //   for (let i = 0; i < 1000; i++) {
  //     let msg: TextMessage | ImageMessage;
  //     let msgBody: MessageBase;
  //     if (sum % 2 === 0) {
  //       msg = new TextMessage(chatDetailMsgList[i % Constants.MOCK_ELEMENT_COUNT]);
  //       if (i % 2 === 0) {
  //         msgBody = new MessageBase(i.toString(), userFriend, userMyself, msg, "1", todayDate.getSeconds().toString());
  //       } else {
  //         msgBody = new MessageBase(i.toString(), userMyself, userFriend, msg, "1", todayDate.getSeconds().toString());
  //       }
  //     } else {
  //       let imageStr = `/resources/images/photo${(i % 50).toString()}.jpg`;
  //       msg = new ImageMessage(40, 50, imageStr);
  //       if (i % 2 === 0) {
  //         msgBody = new MessageBase(i.toString(), userFriend, userMyself, msg, "2", todayDate.getSeconds().toString());
  //       } else {
  //         msgBody = new MessageBase(i.toString(), userMyself, userFriend, msg, "2", todayDate.getSeconds().toString());
  //       }
  //     }
  //     if (i % 2 === 0) {
  //       sum++;
  //     }
  //     this.chatDetailData.pushData(msgBody);
  //   }
  //   if (this.wantId === 1) {
  //     let lastMsg = new ImageTextMessage(200, 100, this.wantParams.srcImage, this.wantParams.textContent);
  //     this.chatDetailData.pushData(new MessageBase('1000', userMyself, userFriend, lastMsg, "3", todayDate.getSeconds().toString()));
  //   } else if (this.wantId === 2) {
  //     await this.fdTransformPixelMap();
  //     if (this.imageFile !== undefined) {
  //       let lastMsg = new FileMessage(180, 200, this.imageFile);
  //       this.chatDetailData.pushData(new MessageBase('1000', userMyself, userFriend, lastMsg, "3", todayDate.getSeconds().toString()));
  //     }
  //   }
  //   this.msgLength = this.chatDetailData.totalCount();
  //   hiTraceMeter.finishTrace(MAKE_DATA_LOCAL_TRACE, MAKE_DATA_LOCAL_TRACE_ID);
  // }

  async aboutToAppear() {
    await this.getWant();
    hiTraceMeter.startTrace(ABOUT_TO_APPEAR_TRACE, ABOUT_TO_APPEAR_TRACE_ID);
    const requestOptions: RequestOptions = { // 发送一条message
      url: "http://172.29.4.148:8080/v2/getMessages?" + "ownerUid=" + globalThis.UID + "&friendUid=" + this.chatId.toString(),
      method: RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      },
    };
    // 调用HttpManager的request方法，发起POST请求
    HttpManager.getInstance().request<ResponseResult>(requestOptions)
      .then((result) => {
        console.info("get MessageList on appear" + JSON.stringify(result.data)); //输出
        // 表示成功
        Object.assign(this.chatDetailData.msgList, result.data) // 填充聊天信息
      })
      .catch((err) => {
        console.error(JSON.stringify(err));
      });

    this.userMyself = new ChatContact(globalThis.UID, globalThis.USERNAME, '')
    this.userFriend = new ChatContact(this.chatId.toString(), this.chatName, this.chatImg)

    // // 在展现前就开始监听服务端发来的消息
    // globalThis.WS.on('message', (err, value) => {
    //   console.log("on message, message:" + value);
    //
    //
    //
    //   // 接收服务端传来的消息
    //   this.todayDate = new Date();
    //   let msg = new TextMessage(value as string);
    //   let msgBody = new MessageBase(this.chatDetailData.totalCount()
    //     .toString(), this.userFriend, this.userMyself, msg, 2, this.todayDate.getSeconds().toString());
    //   this.chatDetailData.pushData(msgBody);
    //   this.msgLength = this.chatDetailData.totalCount();
    //   this.scroller.scrollToIndex(this.msgLength - 1);
    //
    //   const requestOptions: RequestOptions = {
    //     url: "http://172.29.4.148:8080/v2/sendMessage",//
    //     method: RequestMethod.POST,
    //     header: {
    //       'Content-Type': 'application/json'
    //     },
    //     extraData: JSON.stringify({
    //       MessageBase:msgBody
    //     })
    //   };
    //   // 调用HttpManager的request方法，发起POST请求
    //   HttpManager.getInstance().request<ResponseResult>(requestOptions)
    //     .then((result) => {
    //       console.info(JSON.stringify(result.data));//输出
    //       // 表示成功y
    //     })
    //     .catch((err) => {
    //       console.error(JSON.stringify(err));
    //     });
    //   // 当收到服务器的`bye`消息时（此消息字段仅为示意，具体字段需要与服务器协商），主动断开连接
    //   if (value === 'bye') {
    //     globalThis.WS.close((err, value) => {
    //       if (!err) {
    //         console.log("Connection closed successfully");
    //
    //       } else {
    //         console.log("Failed to close the connection. Err: " + JSON.stringify(err));
    //       }
    //     });
    //   }
    // });
    // 填充假数据
    // this.makeDataLocal();
    hiTraceMeter.finishTrace(ABOUT_TO_APPEAR_TRACE, ABOUT_TO_APPEAR_TRACE_ID);
  }

}


