import hiTraceMeter from '@ohos.hiTraceMeter';
import { makeDataLocal, makeDataList } from '../../utils/DataFactory';
import Constants from '../../utils/Constants';
import { ContactsView, ReusableContactsView } from '../../view/ContactsView';
import { OptLayoutContactsView, ReusableOptLayoutContactsView } from '../../view/OptLayoutContactsView';
import Logger from '../../utils/Logger';
import { ChatModel } from '../../viewmodel/MsgBase';
import { ChatListData } from '../../viewmodel/ChatListDataSource';
import { NewFriendsView, ReusableNewFriendsView } from '../../view/NewFriendsView';


const TAG: string = 'NewFriendsListDisplayView';
// 搜索框中搜索栏的ID
const ID_SEARCH: string = 'search';
// 删除item后，下方的item顶上来的动画的播放时间
const DELETE_ANIMATION_DURATION: number = 500;
const ABOUT_TO_APPEAR_TRACE: string = 'NewFriendsListPage_AboutToAppear_HiTrace';
const ABOUT_TO_APPEAR_TRACE_ID: number = 3; // aboutToAppear 中使用的 taskId
const REUSE_ID: string = 'NewFriendsListPage_ReuseId';

class Message {
  contactItem: ChatModel;

  constructor(contactItem: ChatModel) {
    this.contactItem = contactItem;
  }
}

@Entry
@Preview
@Component
export struct NewFriendsListDisplayView {
  // 懒加载的数据列表
  private newFriendsListLazy = new ChatListData();
  // 普通加载的数据列表
  @State newFriendsListArray: Array<ChatModel> = new Array<ChatModel>();
  // 是否使用懒加载
  @StorageLink('lazy_for_each') lazyForEach: boolean | undefined = AppStorage.Get('lazy_for_each');
  // 是否复用列表中的子组件
  @StorageLink('reusable') reusable: boolean | undefined = AppStorage.Get('reusable');
  // 列表数据是否缓存
  @StorageLink('list_cached_count') listCachedCount: boolean | undefined = AppStorage.Get('list_cached_count');
  // 是否使用布局优化
  @StorageLink('page_layout') pageLayout: boolean | undefined = AppStorage.Get('page_layout');

  //页面传参
  private test: boolean = false;

  // 非布局优化的列表item加载数据
  @Builder
  NewFriendsViewBuilder(msg: ChatModel) {
    // reusable component
    if (this.reusable) {
      ReusableNewFriendsView(new Message(msg))
      // .reuseId(REUSE_ID)
    } else {
      NewFriendsView(new Message(msg))
    }
  }

  // 布局优化的列表item加载数据
  // TODO-联系人: OptLayoutNewFriendsView
  @Builder
  OptNewFriendsViewBuilder(msg: ChatModel) {
    // reusable component
    if (this.reusable) {
      ReusableOptLayoutContactsView(new Message(msg))
      //.reuseId(REUSE_ID)
    } else {
      OptLayoutContactsView(new Message(msg))
    }
  }

  build() {
    Column() {
      List() {
        if (this.lazyForEach) {
          // 懒加载加载数据
          LazyForEach(this.newFriendsListLazy, (msg: ChatModel) => {
            ListItem() {
              if (this.pageLayout) {
                // 使用布局优化时加载的item
                this.NewFriendsViewBuilder(msg);
              } else {
                // 不使用布局优化时加载的item
                this.NewFriendsViewBuilder(msg);
              }
            }
          }, (msg: ChatModel) => msg.user.userId)
        } else {
          ForEach(this.newFriendsListArray, (msg: ChatModel) => {
            ListItem() {
              if (this.pageLayout) {
                // 使用布局优化时加载的item
                this.NewFriendsViewBuilder(msg);
              } else {
                // 不使用布局优化时加载的item
                this.NewFriendsViewBuilder(msg);
              }
            }
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
      .height($r('app.string.layout_82'))
      .width($r('app.string.layout_100'))
      .cachedCount(this.listCachedCount ? Constants.CACHED_COUNT : Constants.CACHED_COUNT_0) // 缓存列表数量
    }
  }

  async aboutToAppear(): Promise<void> {
    Logger.info(TAG, "ContactsListPage aboutToAppear");
    hiTraceMeter.startTrace(ABOUT_TO_APPEAR_TRACE, ABOUT_TO_APPEAR_TRACE_ID);
    //this.controller.stopEditing();
    await makeDataLocal(this.newFriendsListLazy);
    await makeDataList(this.newFriendsListArray);
    hiTraceMeter.finishTrace(ABOUT_TO_APPEAR_TRACE, ABOUT_TO_APPEAR_TRACE_ID);
  }
}