import hiTraceMeter from '@ohos.hiTraceMeter';
import { makeDataLocal, makeDataList } from '../../utils/DataFactory';
import Constants from '../../utils/Constants';
import { ChatModel } from '../../viewmodel/MsgBase';
import { ChatListData } from '../../viewmodel/ChatListDataSource';
import { ChatView, ReusableChatView } from '../../view/ChatView';
import Logger from '../../utils/Logger';
import router from '@ohos.router';
import { RequestMethod, RequestOptions } from '../../utils/http/RequestOptions';
import { HttpManager } from '../../utils/http/HttpManager';
import { ResponseResult } from '../../utils/http/HttpCore';

const TAG: string = 'ChatListDisplayView';
// 删除item后，下方的item顶上来的动画的播放时间
const DELETE_ANIMATION_DURATION: number = 500;
const ABOUT_TO_APPEAR_TRACE: string = 'ChatListPage_AboutToAppear_HiTrace';
const ABOUT_TO_APPEAR_TRACE_ID: number = 3; // aboutToAppear 中使用的 taskId
const REUSE_ID: string = 'ChatListPage_ReuseId';

class Message {
  chatItem: ChatModel;

  constructor(chatItem: ChatModel) {
    this.chatItem = chatItem;
  }
}
@Entry
@Preview
@Component
export struct ChatListDisplayView {
  // 懒加载的数据列表
  private chatListLazy = new ChatListData();
  // 普通加载的数据列表
  @State chatListArray: Array<ChatModel> = new Array<ChatModel>();
  // 是否使用懒加载
  @StorageLink('lazy_for_each') lazyForEach: boolean | undefined = AppStorage.Get('lazy_for_each');
  // 是否复用列表中的子组件
  @StorageLink('reusable') reusable: boolean | undefined = AppStorage.Get('reusable');
  // 列表数据是否缓存
  @StorageLink('list_cached_count') listCachedCount: boolean | undefined = AppStorage.Get('list_cached_count');
  // 是否使用布局优化-弃用
  @StorageLink('page_layout') pageLayout: boolean | undefined = AppStorage.Get('page_layout');


  // 布局优化的列表item加载数据
  @Builder
  OptChatViewBuilder(msg: ChatModel) {
    // reusable component
    if (this.reusable) {
      ReusableChatView(new Message(msg))
        //.reuseId(REUSE_ID)
    } else {
      ChatView(new Message(msg))
    }
  }

  // List的item左划时显示的删除按钮
  @Builder
  deleteAction(msg: ChatModel) {
    Row() {
      Image(($r('app.media.icon_delete')))
        .onClick(() => {
          animateTo({ duration: DELETE_ANIMATION_DURATION }, () => {
            if (this.lazyForEach) {
              this.chatListLazy.deleteData(msg);
            } else {
              let index = this.chatListArray.indexOf(msg);
              this.chatListArray.splice(index, 1);
            }
          })
        })
        .width($r('app.integer.chat_list_delete_width'))
        .height($r('app.integer.chat_list_delete_height'))
    }
    .width($r('app.integer.chat_list_page_delete_row_width'))
    .height($r('app.string.layout_100'))
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  build() {
    Column() {

      List() {
        if (this.lazyForEach) {
          // 懒加载加载数据
          LazyForEach(this.chatListLazy, (msg: ChatModel) => {
            ListItem() {
              this.OptChatViewBuilder(msg);
            }
           // .transition( TransitionEffect.OPACITY) // 删除item后，List显示的最后一个item顶上来的动画 TransitionEffect.OPACITY
            .swipeAction({ // 用于设置ListItem的划出组件，end是ListItem向左划动时item右边的组件（List垂直布局时）或ListItem向上划动时item下方的组件（List水平布局时）
              end: this.deleteAction(msg),
            })
          }, (msg: ChatModel) => msg.user.userId)
        } else {
          ForEach(this.chatListArray, (msg: ChatModel) => {
            ListItem() {
              this.OptChatViewBuilder(msg);
            }
            //.transition(TransitionEffect.OPACITY) // 删除item后，List显示的最后一个item顶上来的动画
            .swipeAction({ // 用于设置ListItem的划出组件，end是ListItem向左划动时item右边的组件（List垂直布局时）或ListItem向上划动时item下方的组件（List水平布局时）
              end: this.deleteAction(msg),
            })
          }, (msg: ChatModel) => msg.user.userId)
        }
      }
      .backgroundColor(Color.White)
      .listDirection(Axis.Vertical)
      .divider({
        strokeWidth: $r('app.integer.chat_list_divider_stroke_width'),
        color: $r('app.color.chat_list_divider_color'),
        startMargin: $r('app.integer.chat_list_page_start_margin'),
        endMargin: $r('app.integer.opt_layout_chat_view_item_padding_right')
      })
      .height('94%')
      .width($r('app.string.layout_100'))
      .cachedCount(this.listCachedCount ? Constants.CACHED_COUNT : Constants.CACHED_COUNT_0) // 缓存列表数量
    }
  }

  async aboutToAppear(): Promise<void> {
    Logger.info(TAG, "ChatListPage aboutToAppear");
    hiTraceMeter.startTrace(ABOUT_TO_APPEAR_TRACE, ABOUT_TO_APPEAR_TRACE_ID);

    /**
     * uid ->  Array<ChatModel>,填充真数据
     */

    // const requestOptions: RequestOptions = {
    //   url: "172.29.4.148:8080/v1/getChatModelList?uid="+globalThis.UID,
    //   method: RequestMethod.GET,
    //   header: {
    //     'Content-Type': 'application/json'
    //   },
    // };
    //
    // //
    // HttpManager.getInstance().request<ResponseResult>(requestOptions)
    //   .then((result) => {
    //     if(result.code == '200') {
    //       // 成功返回
    //       console.info(JSON.stringify(result.data)); //信息
    //       Object.assign(this.chatListArray,result.data)//填充正常加载数据
    //       Object.assign(this.chatListLazy.chatList,result.data)// 填充懒加载数据
    //     // 进行数据填充
    //     }
    //   })
    //   .catch((err) => {
    //     console.error(JSON.stringify(err));
    //   });
    // // 把获得的数据放入当前展示的列表中


    // 假数据填充
    await makeDataLocal(this.chatListLazy);
    await makeDataList(this.chatListArray);

    hiTraceMeter.finishTrace(ABOUT_TO_APPEAR_TRACE, ABOUT_TO_APPEAR_TRACE_ID);
  }
}