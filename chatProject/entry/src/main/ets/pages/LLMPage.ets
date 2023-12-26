import router from '@ohos.router';
import {CommonConstants} from '../common/constants/CommonConstants';
import { WantFileModel, WantModel } from '../model/Want';
import { ChatContact, ChatDetailData, ImageMessage, MessageBase, TextMessage } from '../viewmodel/MsgBase';
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
    private chatDetailData = new ChatDetailData();// 根据这个来构造细节聊天界面，通过 msgList 来对界面进行渲染
    private scroller: Scroller = new Scroller();
    @State wantId: number = 0;
    @State userMyselfName: string = '';
    @State userFriendName: string = '';
    @State listHeight: number = 0;

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
                        ChatItemView({ msg: msg });// 通过这个来渲染每个MsgBody
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
                TextInput({ placeholder: '', text: this.keyboardStr })
                    .id('bottomTextInput')
                    .height($r('app.integer.search_inline_height'))
                    .layoutWeight(LAYOUT_WEIGHT)
                    .borderRadius($r('app.integer.search_border_radius'))
                    .backgroundColor($r('app.string.chat_detail_input_background'))
                    .enterKeyType(EnterKeyType.Send)
                    .onChange((value: string) => {
                        this.keyboardStr = value;
                    })
                    .onSubmit(() => {

                        this.todayDate = new Date();
                        let msg = new TextMessage(this.keyboardStr);
                        let msgBody = new MessageBase(this.chatDetailData.totalCount()
                            .toString(), this.userMyself, this.gpt, msg, 1, this.todayDate.getSeconds());
                        this.chatDetailData.pushData(msgBody);
                        this.msgLength = this.chatDetailData.totalCount();
                        this.scroller.scrollToIndex(this.msgLength - 1);

                        // 本地渲染后发送到后端
                        const requestOptions: RequestOptions = {
                            url: "http://172.29.4.148:8080/",// TODO-大语言url
                            method: RequestMethod.POST,
                            header: {
                                'Content-Type': 'application/json'
                            },
                            extraData: {
                                //"uid" : this.myUid, // 通过uid,message 进行通信
                                "message" : this.keyboardStr
                            }
                        };

                        // 调用HttpManager的request方法，发起POST请求
                        HttpManager.getInstance().request<ResponseResult>(requestOptions)
                            .then((result) => {
                                console.info(JSON.stringify(result.data));//输出用户信息并跳转
                                // 获得大语言模型返回数据
                                this.todayDate = new Date();
                                msg = new TextMessage(JSON.parse(JSON.stringify(result.data)));// 解析返回数据
                                msgBody = new MessageBase(this.chatDetailData.totalCount()
                                    .toString(), this.gpt, this.userMyself, msg, 1, this.todayDate.getSeconds());
                                this.chatDetailData.pushData(msgBody); // 进行渲染
                            })
                            .catch((err) => {
                                console.error(JSON.stringify(err));
                            });
                        this.keyboardStr = '';// 刷新输入栏
                    })
                Text('发送')
                    .height(24)
                    .width(52)
                    .backgroundColor(Color.Blue)// 蓝色
                    .fontColor(Color.White)
                    .margin({ right: 16 })
                    .onClick(() => {
                        this.todayDate = new Date();
                        let msg = new TextMessage(this.keyboardStr);
                        let msgBody = new MessageBase(this.chatDetailData.totalCount()
                            .toString(), this.userMyself, this.gpt, msg, 1, this.todayDate.getSeconds());
                        this.chatDetailData.pushData(msgBody);
                        this.msgLength = this.chatDetailData.totalCount();
                        this.scroller.scrollToIndex(this.msgLength - 1);
                        this.keyboardStr = '';
                    })

            }
            .borderRadius({
                topLeft: $r('app.integer.search_border_radius'),
                topRight: $r('app.integer.search_border_radius')
            })
            .backgroundColor(Color.White)
            .width($r('app.string.layout_100'))
            .height($r('app.integer.search_outline_height'))
        }
        .padding({ bottom: px2vp((this.keyboardHeight)) })
        .backgroundColor($r('app.color.detail_body_background'))
        .height($r('app.string.layout_100'))
    }
}