import hiTraceMeter from '@ohos.hiTraceMeter';
import { makeDataLocal, makeDataList } from '../../utils/DataFactory';
import Constants from '../../utils/Constants';
import { ContactsView, ReusableContactsView } from '../../view/ContactsView';
import { OptLayoutContactsView, ReusableOptLayoutContactsView } from '../../view/OptLayoutContactsView';
import Logger from '../../utils/Logger';
import effectKit from '@ohos.effectKit';
import { ChatModel } from '../../viewmodel/MsgBase';
import { ChatListData } from '../../viewmodel/ChatListDataSource';


const TAG: string = 'ContactsListDisplayView';
// 搜索框中搜索栏的ID
const ID_SEARCH: string = 'search';
// 删除item后，下方的item顶上来的动画的播放时间
const DELETE_ANIMATION_DURATION: number = 500;
const ABOUT_TO_APPEAR_TRACE: string = 'ContactsListPage_AboutToAppear_HiTrace';
const ABOUT_TO_APPEAR_TRACE_ID: number = 3; // aboutToAppear 中使用的 taskId
const REUSE_ID: string = 'ContactsListPage_ReuseId';

class Message {
  contactItem: ChatModel;

  constructor(contactItem: ChatModel) {
    this.contactItem = contactItem;
  }
}
@Entry
@Preview
@Component
export struct ContactsListDisplayView {
  // 懒加载的数据列表
  private contactsListLazy = new ChatListData();
  // 普通加载的数据列表
  @State contactsListArray: Array<ChatModel> = new Array<ChatModel>();
  // 是否使用懒加载
  @StorageLink('lazy_for_each') lazyForEach: boolean | undefined = AppStorage.Get('lazy_for_each');
  // 是否复用列表中的子组件
  @StorageLink('reusable') reusable: boolean | undefined = AppStorage.Get('reusable');
  // 列表数据是否缓存
  @StorageLink('list_cached_count') listCachedCount: boolean | undefined = AppStorage.Get('list_cached_count');
  // 是否使用布局优化
  @StorageLink('page_layout') pageLayout: boolean | undefined = AppStorage.Get('page_layout');
  controller: SearchController = new SearchController();

  // 非布局优化的列表item加载数据
  @Builder
  ContactsViewBuilder(msg: ChatModel) {
    // reusable component
    if (this.reusable) {
      ReusableContactsView(new Message(msg))
      // .reuseId(REUSE_ID)
    } else {
      ContactsView(new Message(msg))
    }
  }

  // 布局优化的列表item加载数据
  @Builder
  OptContactsViewBuilder(msg: ChatModel) {
    // reusable component
    if (this.reusable) {
      ReusableOptLayoutContactsView(new Message(msg))
      //.reuseId(REUSE_ID)
    } else {
      OptLayoutContactsView(new Message(msg))
    }
  }

  // TODO-联系人：删除好友功能
  // // List的item左划时显示的删除按钮
  // @Builder
  // deleteAction(msg: ChatModel) {
  //   Row() {
  //     Image(($r('app.media.icon_delete')))
  //       .onClick(() => {
  //         animateTo({ duration: DELETE_ANIMATION_DURATION }, () => {
  //           if (this.lazyForEach) {
  //             this.contactsListLazy.deleteData(msg);
  //           } else {
  //             let index = this.chatListArray.indexOf(msg);
  //             this.chatListArray.splice(index, 1);
  //           }
  //         })
  //       })
  //       .width($r('app.integer.chat_list_delete_width'))
  //       .height($r('app.integer.chat_list_delete_height'))
  //   }
  //   .width($r('app.integer.chat_list_page_delete_row_width'))
  //   .height($r('app.string.layout_100'))
  //   .justifyContent(FlexAlign.SpaceEvenly)
  // }

  build() {
    Column() {
      // 搜索栏准备用别的方法实现
      // Row() {
      //   Search({ placeholder: "搜索..." })// api9不支持使用resource标志string?
      //     // .enableKeyboardOnFocus(false) //是否调用键盘
      //     .placeholderFont({ size: $r('app.integer.search_font_size') })
      //     .searchIcon({ src: $r('app.media.search_svg'), size: $r('app.integer.search_svg_height') })
      //     .placeholderColor($r('app.string.search_inline_border_color'))
      //     .backgroundColor(Color.White)
      //     .height($r('app.integer.search_inline_height'))
      //     .margin({left: $r('app.integer.search_inline_margin'), right: $r('app.integer.search_inline_margin')})
      //     .textFont({ size: $r('app.integer.search_font_size') })
      //     .border({
      //       width: $r('app.integer.search_inline_border_width'),
      //       color: $r('app.string.search_inline_border_color')
      //     })
      //     .borderRadius($r('app.integer.search_border_radius'))
      //     .id(ID_SEARCH)
      // }
      // .alignItems(VerticalAlign.Center)
      // .justifyContent(FlexAlign.Center)
      // .height($r('app.integer.search_outline_height'))
      // .width($r('app.string.layout_100'))
      // .backgroundColor($r('app.color.search_outline_background_color'))

      List() {
        if (this.lazyForEach) {
          // 懒加载加载数据
          LazyForEach(this.contactsListLazy, (msg: ChatModel) => {
            ListItem() {
              if (this.pageLayout) {
                // 使用布局优化时加载的item
                this.OptContactsViewBuilder(msg);
              } else {
                // 不使用布局优化时加载的item
                this.ContactsViewBuilder(msg);
              }
            }
            // .transition( TransitionEffect.OPACITY) // 删除item后，List显示的最后一个item顶上来的动画 TransitionEffect.OPACITY
            // .swipeAction({ // 用于设置ListItem的划出组件，end是ListItem向左划动时item右边的组件（List垂直布局时）或ListItem向上划动时item下方的组件（List水平布局时）
            //   end: this.deleteAction(msg),
            // })
          }, (msg: ChatModel) => msg.user.userId)
        } else {
          ForEach(this.contactsListArray, (msg: ChatModel) => {
            ListItem() {
              if (this.pageLayout) {
                // 使用布局优化时加载的item
                this.OptContactsViewBuilder(msg);
              } else {
                // 不使用布局优化时加载的item
                this.ContactsViewBuilder(msg);
              }
            }
            //.transition(TransitionEffect.OPACITY) // 删除item后，List显示的最后一个item顶上来的动画
            // .swipeAction({ // 用于设置ListItem的划出组件，end是ListItem向左划动时item右边的组件（List垂直布局时）或ListItem向上划动时item下方的组件（List水平布局时）
            //   end: this.deleteAction(msg),
            // })
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
    await makeDataLocal(this.contactsListLazy);
    await makeDataList(this.contactsListArray);
    hiTraceMeter.finishTrace(ABOUT_TO_APPEAR_TRACE, ABOUT_TO_APPEAR_TRACE_ID);
  }
}