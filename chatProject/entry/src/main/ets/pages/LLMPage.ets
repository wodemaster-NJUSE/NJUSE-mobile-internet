import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import { WantFileModel, WantModel } from '../model/Want';
import { ChatContact, ChatDetailData, ImageMessage,
    ImageTextMessage,
    MessageBase, TextMessage } from '../viewmodel/MsgBase';
import Want from '@ohos.app.ability.Want';
import image from '@ohos.multimedia.image';
import { ChatItemView } from './chatPages/ChatItemView';
import { RequestMethod, RequestOptions } from '../utils/http/RequestOptions';
import { HttpManager } from '../utils/http/HttpManager';
import { ResponseResult } from '../utils/http/HttpCore';
import hiTraceMeter from '@ohos.hiTraceMeter';


const ABOUT_TO_APPEAR_TRACE: string = 'ChatDetailPage_AboutToAppear_HiTrace';
const ABOUT_TO_APPEAR_TRACE_ID: number = 1; // aboutToAppear 中使用的 taskId
const STROKE_WIDTH: number = 2; // strokeWidth的宽度
const LAYOUT_WEIGHT: number = 1; // layoutWeight参数
@Entry
@Component
export struct LLMPage {
    // 用户使用uid和大语言进行通信
    @State myUid:string = '';

    @StorageLink('keyboardHeight') keyboardHeight: number = 0;
    @State msgLength: number = 0;
    userMyself = new ChatContact('1', $r('app.string.myself'));// id(用来判断是对方还是我),名称，头像可选,构建默认聊天对象
    gpt = new ChatContact('2', "小智");//构造gpt的默认聊天对象
    msgAnother = new TextMessage('hello,小智');
    todayDate = new Date();
    msgBody = new MessageBase('1', this.userMyself, this.gpt, this.msgAnother, 1, this.todayDate.getSeconds());
    // 消息体构造：消息id，来自，去往，消息，消息类型（文本，图片，文本加图片，网络图片），日期
    @State keyboardStr: string = '';// 键盘输入
    @State private chatDetailData: ChatDetailData = new ChatDetailData();// 根据这个来构造细节聊天界面，通过 msgList 来对界面进行渲染
    private scroller: Scroller = new Scroller();
    @State wantId: number = 0;
    @State userMyselfName: string = '';
    @State userFriendName: string = '';
    @State listHeight: number = 0;

    // 设置列表项的键值
    index_count: number = 1;

    // 设置发送按钮
    @State sendState: boolean = false;

    build() {
        Column() {
            // 顶部导航栏
            Row() {
                Row() {
                    Image($r('app.media.ic_back'))
                        .id('returnBtn')
                        .height(24)
                        .width(24)
                        .margin({
                            left: 14
                        })
                        .onClick(() => {
                            router.back();
                        })

                    Text('小智')
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
                        this.LLMChatItemView(msg);
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

            Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
                TextArea({ placeholder: '', text: this.keyboardStr})
                    .id('bottomTextInput')
                    .height(36)
                    .layoutWeight(1)
                    .borderRadius(2)
                    .backgroundColor(Color.White)
                    .margin({
                        left: 12,
                        right: 8
                    })
                    .onChange((value: string) => {
                        this.keyboardStr = value;
                    })

                Text('发送')
                    .borderRadius(2)
                    .height(36)
                    .width(62)
                    .backgroundColor('#FF6EC2FA')
                    .fontColor(Color.White)
                    .fontSize(12)
                    .margin({ right: 10 })
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                        // 渲染用户发言
                        this.todayDate = new Date();
                        let msg = new TextMessage(this.keyboardStr);
                        let msgBody = new MessageBase(this.index_count.toString(),
                            this.userMyself, this.gpt, msg, 1, this.todayDate.getSeconds());
                        this.index_count = this.index_count + 1;
                        this.chatDetailData.pushData(msgBody);
                        this.msgLength = this.chatDetailData.totalCount();
                        this.scroller.scrollToIndex(this.msgLength - 1);

                        // 渲染LLM加载动画
                        this.todayDate = new Date();
                        msg = new TextMessage('load');
                        msgBody = new MessageBase(this.index_count.toString(),
                            this.gpt, this.userMyself, msg, 5, this.todayDate.getSeconds());
                        this.index_count = this.index_count + 1;
                        this.chatDetailData.pushData(msgBody); // 进行渲染
                        this.msgLength = this.chatDetailData.totalCount();
                        this.scroller.scrollToIndex(this.msgLength - 1);

                        // 渲染LLM发言
                        const requestOptions: RequestOptions = {
                            url: "http://172.29.4.148:8080/LLM/send",
                            method: RequestMethod.POST,
                            header: {
                                'Content-Type': 'application/json'
                            },
                            extraData: {
                                "question" : this.keyboardStr
                            }
                        };

                        // 调用HttpManager的request方法，发起POST请求
                        HttpManager.getInstance().request<ResponseResult>(requestOptions)
                            .then((result) => {
                                console.info('LLM_response' + JSON.stringify(result.data));//输出用户信息并跳转
                                // 获得大语言模型返回数据
                                this.todayDate = new Date();
                                msg = new TextMessage(JSON.parse(JSON.stringify(result.data)));// 解析返回数据
                                msgBody = new MessageBase(this.index_count.toString()
                                    , this.gpt, this.userMyself, msg, 1, this.todayDate.getSeconds());
                                this.index_count = this.index_count + 1;
                                this.chatDetailData.deleteData(this.chatDetailData.totalCount() - 1)
                                this.chatDetailData.pushData(msgBody); // 渲染
                                this.msgLength = this.chatDetailData.totalCount();
                                this.scroller.scrollToIndex(this.msgLength - 1);
                            })
                            .catch((err) => {
                                console.error(JSON.stringify(err));
                            });

                        // 清除聊天框
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

    @Builder LLMChatItemView(msg: MessageBase) {
        Column() {
            if (msg.from.userId != '1') {
                // LLM的消息
                Row() {
                    Image(msg.from.userImage)
                        .width($r('app.integer.opt_layout_chat_view_profile_picture_height'))
                        .height($r('app.integer.opt_layout_chat_view_profile_picture_height'))
                        .borderRadius($r('app.integer.opt_layout_chat_view_profile_picture_radius'))
                    Column() {
                        if (msg.msgType === 1) {
                            Row() {
                                Text((msg.msgBody as TextMessage).msg)
                                    .lineHeight($r('app.integer.search_text_height'))
                                    .constraintSize({ minHeight: $r('app.integer.search_inline_height') })
                                    .fontSize($r('app.integer.search_font_size'))
                                    .fontColor($r('app.color.top_bar_font_color'))
                                    .backgroundColor(Color.White)
                                    .padding({
                                        top: $r('app.integer.layout_8'),
                                        left: $r('app.integer.text_font_13'),
                                        bottom: $r('app.integer.layout_8'),
                                        right: $r('app.integer.text_font_13')
                                    })
                                    .borderRadius({ topLeft: $r('app.integer.layout_4'),
                                        topRight: $r('app.integer.opt_layout_chat_view_item_padding_right'),
                                        bottomLeft: $r('app.integer.opt_layout_chat_view_item_padding_right'),
                                        bottomRight: $r('app.integer.opt_layout_chat_view_item_padding_right')
                                    })
                            }
                        } else if (msg.msgType === 5) { // LLM加载动画
                            LoadingProgress()
                                .color(Color.Blue)
                                .width(108)
                                .height(66)
                                .backgroundColor('#F1F3F5')
                        }
                    }
                    .margin({ left: $r('app.integer.layout_8') })
                    .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .alignItems(VerticalAlign.Top)
                .margin({ top: $r('app.integer.layout_12') })
                .padding({ right: $r('app.integer.chat_view_time_width') })
            } else {
                // 用户消息
                Row() {
                    Image(msg.from.userImage)
                        .width($r('app.integer.opt_layout_chat_view_profile_picture_height'))
                        .height($r('app.integer.opt_layout_chat_view_profile_picture_height'))
                        .borderRadius($r('app.integer.opt_layout_chat_view_profile_picture_radius'))
                    Column() {
                        if (msg.msgType === 1) {
                            Row() {
                                Text((msg.msgBody as TextMessage).msg)
                                    .lineHeight($r('app.integer.search_text_height'))
                                    .constraintSize({ minHeight: $r('app.integer.opt_layout_chat_view_profile_picture_height') })
                                    .fontSize($r('app.integer.search_font_size'))
                                    .backgroundColor($r('app.color.detail_item_message_background'))
                                    .fontColor($r('app.color.top_bar_font_color'))
                                    .padding({
                                        top: $r('app.integer.layout_8'),
                                        left: $r('app.integer.text_font_13'),
                                        bottom: $r('app.integer.layout_8'),
                                        right: $r('app.integer.text_font_13')
                                    })
                                    .borderRadius({
                                        topLeft: $r('app.integer.opt_layout_chat_view_item_padding_right'),
                                        topRight: $r('app.integer.layout_4'),
                                        bottomLeft: $r('app.integer.opt_layout_chat_view_item_padding_right'),
                                        bottomRight: $r('app.integer.opt_layout_chat_view_item_padding_right')
                                    })
                            }
                        }
                    }
                    .margin({ right: $r('app.integer.layout_8') })
                    .alignItems(HorizontalAlign.End)
                }
                .alignItems(VerticalAlign.Top)
                .width('100%')
                .direction(Direction.Rtl)
                .padding({ left: $r('app.integer.chat_view_time_width') })
                .margin({ top: $r('app.integer.layout_12') })
            }
        }
    }
}