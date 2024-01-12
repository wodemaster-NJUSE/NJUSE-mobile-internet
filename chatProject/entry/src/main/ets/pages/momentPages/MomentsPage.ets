import router from '@ohos.router';
import hiTraceMeter from '@ohos.hiTraceMeter';
import http from '@ohos.net.http';
import taskpool from '@ohos.taskpool';
import promptAction from '@ohos.promptAction';
import { ChatContact, FriendMoment } from '../../viewmodel/MsgBase';
import FriendMomentJsonUrl from '../../utils/FriendMomentJsonUrl';
import Logger from '../../utils/Logger';
import { BasicDataSource } from '../../viewmodel/BasicDataSource';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { RequestMethod, RequestOptions } from '../../utils/http/RequestOptions';
import { HttpManager } from '../../utils/http/HttpManager';
import { ResponseResult } from '../../utils/http/HttpCore';
import { getAvatar } from '../../utils/Constants';

const TAG: string = 'entry_MomentsPage';
const ABOUT_TO_APPEAR_TRACE: string = 'FriendsPage_AboutToAppear_HiTrace';
const ABOUT_TO_APPEAR_TRACE_ID: number = 1; // aboutToAppear 中使用的 taskId
const MAKE_LOCAL_DATA_TRACE: string = 'FriendsPage_MakeLocalData_HiTrace';
const MAKE_LOCAL_DATA_TRACE_ID: number = 2; // makeDataLocal 中使用的 taskId
const LAYOUT_WEIGHT: number = 1; // 自动分配剩余空间
const LIST_SPACE: number = 8; // 列表默认间隔
const PROMPT_DURATION: number = 3500; // 提示框持续时间
const GRID_COLUMN_NUMBER: number = 3; // 九宫格每行图片数

@Entry
@Component
struct MomentsPage {
  @State uid:string = globalThis.UID;// 传入uid进行http通信

  @State itemLength: number = 0;
  @State cachedCountNumber: number = 3; // 懒加载缓存数
  // 通过填充momentList来展示动态列表
  @StorageLink('momentData') momentData: FriendMomentsData = new FriendMomentsData();
  // 获取全部的动态，在这里填充
  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_back'))
          .height($r('app.integer.friendMomentsPage_title_icon_width'))
          .width($r('app.integer.friendMomentsPage_title_icon_height'))
          .objectFit(ImageFit.Contain)
          .onClick(() => {
            router.back()
          })
          .syncLoad(true)

        Text($r('app.string.moment'))
          .fontSize($r('app.integer.friendMomentsPage_title_fontSize'))
          .fontColor($r('app.color.title_font_color'))
          .fontWeight(FontWeight.Bold)
          .margin({ left: $r('app.integer.friendMomentsPage_title_margin_left') })
          .fontFamily($r('app.string.harmony_hei_ti'))
          .lineHeight($r('app.integer.friendMomentsPage_title_line_height'))
          .layoutWeight(LAYOUT_WEIGHT)

        Image($r('app.media.camera'))
          .height($r('app.integer.friendMomentsPage_title_icon_height'))
          .width($r('app.integer.friendMomentsPage_title_icon_width'))
          .objectFit(ImageFit.Contain)
          .onClick(()=>{
            // 点击进入到添加动态界面
            router.pushUrl({
              url: CommonConstants.ADD_MOMENTS_PAGE_URL,
            })
          })
      }
      .alignItems(VerticalAlign.Center)
      .height($r('app.integer.friendMomentsPage_title_height'))
      .width($r('app.string.layout_100'))
      .padding({
        left: $r('app.integer.friendMomentsPage_title_padding_left'),
        right: $r('app.integer.friendMomentsPage_title_padding_right'),
        top: $r('app.integer.friendMomentsPage_title_padding_top'),
        bottom: $r('app.integer.friendMomentsPage_title_padding_bottom')
      })
      .margin({
        top : 20
      })

      Column() {
        List({ space: LIST_SPACE }) {
          LazyForEach(this.momentData, (moment: FriendMoment) => {
            ListItem() {
              OneMoment({ moment: moment })// 使用OneMoment对单个动态进行渲染
            }
          }, (moment: FriendMoment) => moment.id)
        }
        .cachedCount(this.cachedCountNumber)
        .width($r('app.string.layout_100'))
        .height($r('app.string.layout_100'))
        .listDirection(Axis.Vertical)
        .divider({
          strokeWidth: $r('app.integer.friends_page_divider_width'),
          color: $r('app.color.friends_page_divider_color'),
          startMargin: $r('app.integer.friendMomentsPage_list_divider_margin'),
          endMargin: $r('app.integer.friendMomentsPage_list_divider_margin')
        })
      }
      .height($r('app.string.layout_100'))
      .layoutWeight(LAYOUT_WEIGHT)
    }
    .height($r('app.string.layout_100'))
    .width($r('app.string.layout_100'))
  }

  async aboutToAppear(): Promise<void> {
    hiTraceMeter.startTrace(ABOUT_TO_APPEAR_TRACE, ABOUT_TO_APPEAR_TRACE_ID);
    Logger.info(TAG, 'aboutToAppear');
    // 真数据请求
    const requestOptions: RequestOptions = {// 获取所有动态
      url: "http://172.29.4.148:8080/v1/getZoneMomentModels?uid="+this.uid,
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

          console.info("jhgvjhchg" + JSON.stringify(result.data)); //信息
          Object.assign(this.momentData.momentList,result.data) // 进行数据填充
        }
      })
      .catch((err) => {
        console.error(JSON.stringify(err));
      });
    //await this.makeLocalData();  // 在这里假数据填充
    hiTraceMeter.finishTrace(ABOUT_TO_APPEAR_TRACE, ABOUT_TO_APPEAR_TRACE_ID);
  }

  // 本地mock数据生成朋友圈数据，推到momentData里
  async makeLocalData(): Promise<void> {
    Logger.info(TAG, 'makeLocalData');
    hiTraceMeter.startTrace(MAKE_LOCAL_DATA_TRACE, MAKE_LOCAL_DATA_TRACE_ID);
    /**
     * 假数据填充
     */
    let friendMomentArray: Array<FriendMoment> = await getWebData(FriendMomentJsonUrl.FRIEND_MOMENT_JSON_URL[0]);

    if (friendMomentArray) {
      for (let i = 0; i < friendMomentArray.length; i++) {
        this.momentData.pushData(friendMomentArray[i]);
      }
    } else {
      try {
        promptAction.showToast({
          message: $r('app.string.friendMomentsPage_prompt_message'),
          duration: PROMPT_DURATION
        });
      } catch (error) {
        Logger.info('cannot contact with internet')
      }
    }

    hiTraceMeter.finishTrace(MAKE_LOCAL_DATA_TRACE, MAKE_LOCAL_DATA_TRACE_ID);
  }
}

@Component
struct OneMoment {
  private moment: FriendMoment = new FriendMoment('', new ChatContact('', ''), '', '', [], '', '');
  @State imageListMinLength: number = 2;
  @State liked: boolean = false; // 是否点赞

  build() {
    Column() {
      Row() {
        // 头像
        Image(getAvatar(this.moment.user.userId))
          .id('userImage')
          .autoResize(false)
          .width($r('app.integer.friendMomentsPage_user_image_width'))
          .height($r('app.integer.friendMomentsPage_user_image_height'))
          .borderRadius($r('app.integer.friendMomentsPage_user_image_border_radius'))
        Column() {
          // Row() {
          //   // 用户名
          //   Text(this.moment.user.userName)
          //     .fontSize($r('app.integer.friendMomentsPage_useName_fontSize'))
          //     .fontColor($r('app.color.title_font_color'))
          //     .lineHeight($r('app.integer.friendMomentsPage_useName_line_height'))
          //     .fontFamily($r('app.string.harmony_hei_ti'))
          //     .fontWeight(FontWeight.Medium)
          //
          //   // 时间
          //   Text('2023年06月21日 19:20') // TODO
          //     .fontSize(12)
          //     .fontColor(Color.Gray)
          //     .lineHeight($r('app.integer.friendMomentsPage_useName_line_height'))
          //     .fontFamily($r('app.string.harmony_hei_ti'))
          //     .fontWeight(FontWeight.Normal)
          //     .margin({left: 20})
          // }
          // .width('100%')
          // .height(22)
          // .justifyContent(FlexAlign.Start)

          Text(this.moment.user.userName)
            .fontSize($r('app.integer.friendMomentsPage_useName_fontSize'))
            .fontColor($r('app.color.title_font_color'))
            .lineHeight($r('app.integer.friendMomentsPage_useName_line_height'))
            .fontFamily($r('app.string.harmony_hei_ti'))
            .fontWeight(FontWeight.Medium)

          Text(this.moment.time) // TODO
            .fontSize(12)
            .fontColor(Color.Gray)
            .lineHeight($r('app.integer.friendMomentsPage_userText_line_height'))
            .opacity($r('app.float.opacity_zero_point_six'))
            .fontFamily($r('app.string.harmony_hei_ti'))
            .margin({ top: 0 })
        }
        .margin({ left: $r('app.integer.friendMomentsPage_user_col_margin_left') })
        .layoutWeight(LAYOUT_WEIGHT)
        .alignItems(HorizontalAlign.Start)
      }
      .width($r('app.string.layout_100'))
      .constraintSize({ minHeight: $r('app.integer.friendMomentsPage_oneMoment_height') })
      .padding({
        left: $r('app.integer.friendMomentsPage_row_padding_left'),
        right: $r('app.integer.friendMomentsPage_row_padding_right'),
        top: $r('app.integer.friendMomentsPage_row_padding_top'),
        bottom: $r('app.integer.friendMomentsPage_row_padding_bottom')
      })

      Row () {
        Text(this.moment.text)
          .fontSize(16)
          .fontColor(Color.Black)
          .lineHeight($r('app.integer.friendMomentsPage_userText_line_height'))
          .margin({ top: $r('app.integer.friendMomentsPage_userText_margin_top') })
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .padding({
        left: 60,
        right: 60
      })

      // Column() {
      //   if (this.moment.imageList.length) {
      //     if (this.moment.imageList.length >= this.imageListMinLength) {
      //       GridRow({ columns: GRID_COLUMN_NUMBER, gutter: $r('app.integer.friendMomentsPage_grid_gap') }) {
      //         ForEach(this.moment.imageList, (image: string, index?: number) => {
      //           GridCol() {
      //             Image(image)
      //               .id(`${index}`)
      //               .width($r('app.integer.friendMomentsPage_image_width'))
      //               .height($r('app.integer.friendMomentsPage_image_height'))
      //               .borderRadius($r('app.integer.friendMomentsPage_image_radius'))
      //               .onClick(() => {
      //                 router.pushUrl({
      //                   url: CommonConstants.FULL_IMAGE_PAGE_URL,
      //                   params: {
      //                     resourceUrl: JSON.stringify(this.moment.imageList),
      //                     isMedia: false,
      //                     imageIndex: index,
      //                     isMultipleImages: true
      //                   }
      //                 })
      //               })
      //           }
      //         }, (image: string) => image)
      //       }
      //       .width($r('app.integer.friendMomentsPage_grid_height'))
      //     }
      //     else {
      //       Image(this.moment.imageList[0])
      //         .id('singleImage')
      //         .width($r('app.integer.friendMomentsPage_single_image_width'))
      //         .height($r('app.integer.friendMomentsPage_single_image_height'))
      //         .borderRadius($r('app.integer.friendMomentsPage_single_image_radius'))
      //         .onClick(() => {
      //           router.pushUrl({
      //             url: 'pages/FullImagePage',
      //             params: {
      //               resourceUrl: this.moment.imageList[0],
      //               isMedia: false
      //             }
      //           })
      //         })
      //     }
      //   }
      //   else {
      //     Stack({ alignContent: Alignment.Center }) {
      //       Image(this.moment.mediaPreview)
      //         .width($r('app.integer.friendMomentsPage_single_video_width'))
      //         .height($r('app.integer.friendMomentsPage_single_video_height'))
      //         .borderRadius($r('app.integer.friendMomentsPage_single_video_radius'))
      //       Image($r('app.media.play'))
      //         .width($r('app.integer.friendMomentsPage_icon_play_width'))
      //         .height($r('app.integer.friendMomentsPage_icon_play_height'))
      //     }
      //     .width($r('app.integer.friendMomentsPage_single_video_width'))
      //     .height($r('app.integer.friendMomentsPage_single_video_height'))
      //     .id('videoComponent')
      //     .onClick(() => {
      //       router.pushUrl({
      //         url: 'pages/FullImagePage',
      //         params: {
      //           resourceUrl: this.moment.media,
      //           isMedia: true
      //         }
      //       })
      //     })
      //   }
      // }
      // .alignItems(HorizontalAlign.Start)
      // .width($r('app.string.layout_100'))
      // .margin({top : 2})
      // .padding({
      //   left: $r('app.integer.friendMomentsPage_image_group_padding_left'),
      //   right: $r('app.integer.friendMomentsPage_image_group_padding_right')
      // })

      Row() {
        Row() {
          // MomentHandler({
          //   imageStr: $r('app.media.ic_share'),
          //   text: $r('app.string.friendMomentsPage_share')
          // })
          MomentHandler({
            imageStr: this.liked ? $r('app.media.ic_thumbsup_pre') : $r('app.media.ic_thumbsup'),
            text: $r('app.string.friendMomentsPage_thumbsup')
          })
            // .margin({ left: $r('app.integer.friendMomentsPage_thumbsup_margin_left') })
            .onClick(() => {
              this.liked = !this.liked
              //TODO: 在这里更新点赞数
            })
          // MomentHandler({
          //   imageStr: $r('app.media.ic_message'),
          //   text: $r('app.string.friendMomentsPage_message')
          // })
          //   .margin({ left: $r('app.integer.friendMomentsPage_message_margin_left') })
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width($r('app.string.layout_100'))
      .margin({
        top: $r('app.integer.friendMomentsPage_handler_margin_top'),
        bottom: $r('app.integer.friendMomentsPage_handler_margin_bottom')
      })
      .padding({
        left: $r('app.integer.friendMomentsPage_handler_padding_left'),
        right: $r('app.integer.friendMomentsPage_handler_padding_right')
      })

    }
    .width($r('app.string.layout_100'))
  }
}

class FriendMomentsData extends BasicDataSource<FriendMoment> {
  momentList: Array<FriendMoment> = []
  getJsonIndex: number = 1

  // 获取数据列表长度
  public totalCount(): number {
    return this.momentList.length;
  }

  // 根据index获取具体项，假数据填充
  public getData(index: number): FriendMoment {
    // 判断组件是否已经缓存到最后一项数据了
    if (index == this.momentList.length - 1) {
      // 目前json文件只有3个，所以对3取余后加一实现循环获取3个json
      getFriendMomentByTaskPool(FriendMomentJsonUrl.FRIEND_MOMENT_JSON_URL[this.getJsonIndex % 3]);
      this.getJsonIndex++;
    }
    return this.momentList[index];
  }

  // 向规定位置添加数据
  public addData(index: number, data: FriendMoment): void {
    this.momentList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  // 向列表追加数据
  public pushData(data: FriendMoment): void {
    this.momentList.push(data);
    this.notifyDataAdd(this.momentList.length - 1);
  }
}

// task任务池
async function getFriendMomentByTaskPool(jsonUrl: string): Promise<void> {
  // 初始化Task对象，传入待执行的方法和参数
  let task: taskpool.Task = new taskpool.Task(getWebData, jsonUrl);
  // 向任务池中添加新对象
  let friendMomentArray: Array<FriendMoment> = await taskpool.execute(task, taskpool.Priority.MEDIUM) as Array<FriendMoment>;
  let momentData: FriendMomentsData | undefined = AppStorage.Get<FriendMomentsData>('momentData');
  if (momentData !== undefined) {
    // 将数组循环写入页面对象中
    for (let i = 0; i < friendMomentArray.length; i++) {
      momentData.pushData(friendMomentArray[i]);
    }
    AppStorage.SetOrCreate('momentData', momentData);
  }
}

class jsonResult {
  FriendMoment: Array<FriendMoment> = new Array();
}

// 获取网络数据
@Concurrent
async function getWebData(url: string): Promise<Array<FriendMoment>> {
  const mydate = new Date();
  Logger.info('getWebData onMessage start:' + mydate.getFullYear() + mydate.getMonth() + mydate.getDate()
   + mydate.getHours() + mydate.getMinutes() + mydate.getSeconds());
  try {
    let webData: http.HttpResponse = await http.createHttp().request(
      url,
      { header: {
        'Content-Type': 'application/json'
      },
        connectTimeout: FriendMomentJsonUrl.CONNECT_TIME, readTimeout: FriendMomentJsonUrl.READ_TIME
      })
    if (typeof (webData.result) === 'string') {
      // 解析json字符串
      let jsonResult = await JSON.parse(webData.result) as jsonResult;
      let jsonObj: Array<FriendMoment> = jsonResult.FriendMoment;
      let friendMomentBuckets: Array<FriendMoment> = new Array<FriendMoment>();
      // 映射json数据为FriendMoment对象
      for (let i = 0; i < jsonObj.length; i++) {
        let contactTemp = new ChatContact(jsonObj[i].user.userId, jsonObj[i].user.userName,
          jsonObj[i].user.userImage);
        let chatModelTemp = new FriendMoment(jsonObj[i].id, contactTemp, jsonObj[i].text, '',
          jsonObj[i].imageList, jsonObj[i].media, jsonObj[i].mediaPreview);
        friendMomentBuckets.push(chatModelTemp);
      }
      // 在TaskPool中模拟耗时操作
      let taskCount: number = 0;
      for (let i = 0;i < 10000; i++) {
        taskCount++;
      }
      Logger.info('getFriendMomentObj onMessage end');
      return friendMomentBuckets;
    } else {
      Logger.info('getWebData makeLocalData get JSON error');
    }
  } catch (err) {
    Logger.error(`get result failed, err is ${err}, code is ${err.code}, message is ${err.message}`);
  }
  return new Array();
}

@Component
struct MomentHandler {
  @Prop imageStr: Resource = $r('app.media.ic_share');
  private text: string | Resource = '';

  build() {
    Row() {
      Image(this.imageStr)
        .height($r('app.integer.friendMomentsPage_handler_icon_height'))
        .width($r('app.integer.friendMomentsPage_handler_icon_width'))
        .objectFit(ImageFit.Contain)
        .autoResize(false)
      Text(this.text)
        .fontSize($r('app.integer.friendMomentsPage_handler_text_font_size'))
        .fontColor($r('app.color.title_font_color'))
        .fontFamily($r('app.string.harmony_hei_ti'))
        .opacity($r('app.float.opacity_zero_point_six'))
        .margin({ left: $r('app.integer.layout_5') })
    }
    .alignItems(VerticalAlign.Center)
  }
}