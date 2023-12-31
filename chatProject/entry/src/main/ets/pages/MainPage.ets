/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


import { ContactsPage } from './ContactsPage';
import { LLMPage } from './LLMPage'
import router from '@ohos.router';
import { ChatListDisplayView } from './chatPages/ChatListPage';

import { DiscoverPage } from './DiscoverPage';
import { ChatPage } from './ChatPage';
import { UserEntity } from '../stores/user';

import webSocket from '@ohos.net.webSocket';

var defaultIpAddress = "ws://172.29.4.148:8080/chat"//
let ws = webSocket.createWebSocket();

const TAB_INDEX_0: number = 0;
const TAB_INDEX_1: number = 1;
const TAB_INDEX_2: number = 2;
const TAB_INDEX_3: number = 3;
// divider组件的strokWidth为1
const DIVIDER_LINE_STROKWIDTH: number = 1;
const TABBAR_SEPARATE_LINE = 0.05;


@Entry
@Component
struct Index {

  // login 跳转到main界面把uid传入
  private params = router.getParams() as Record<string, Object>;
  uid : string  = this.params.uid as string ;


  @StorageLink('page_layout') page_layout: boolean | undefined = AppStorage.Get('page_layout'); // AppStorage中key对应的属性建立双向数据同步
  @State currentIndex: number = TAB_INDEX_0; // tabBar初始选中的位置
  @State message: Resource = $r('app.string.chat');
  private controller: TabsController = new TabsController();
  // 设置tabBar样式的位置、未选中图片、选中图片及文字显示的参数
  @Builder
  TabBuilder(index: number, imageNormal: Resource, imageSelected: Resource, text: Resource) {
    Column() {
      Divider()
        .vertical(false)
        .strokeWidth(DIVIDER_LINE_STROKWIDTH)
        .color($r('app.color.tab_bar_separator_line_color'))
        .opacity(TABBAR_SEPARATE_LINE)
      Image(this.currentIndex === index ? imageSelected : imageNormal)
        .syncLoad(true)
        .width($r('app.integer.tabbar_image_width'))
        .height($r('app.integer.tabbar_image_height'))
        .margin($r('app.integer.tabbar_image_margin'))
        .objectFit(ImageFit.Contain)
      Text(text)
        .fontSize($r('app.integer.tabbar_item_font_size'))
        .fontColor(this.currentIndex === index ?
        $r('app.color.tabbar_font_color_selected') : $r('app.color.tabbar_font_color_normal'));
    }
    .height($r('app.string.layout_100'))
    .width($r('app.string.layout_100'))
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.controller, index: this.currentIndex }) {
      TabContent() {
        Column() {
          ChatPage()
        }
      }
      .tabBar(this.TabBuilder(TAB_INDEX_0,
        $r('app.media.chatIconNormal'),
        $r('app.media.chatIconSelected'),
        $r('app.string.chat')));

      TabContent() {
        ContactsPage({uid:this.uid})
      }
      .tabBar(this.TabBuilder(TAB_INDEX_1,
        $r('app.media.contactIconNormal'),
        $r('app.media.contactIconSelected'),
        $r('app.string.contacts')));

      TabContent() {
        LLMPage({myUid : this.uid})
      }
      .tabBar(this.TabBuilder(TAB_INDEX_2,
        $r('app.media.profileIconNormal'),
        $r('app.media.profileIconSelected'),
        $r('app.string.LLM')));

      TabContent() {
        DiscoverPage({uid:this.uid})
      }
      .tabBar(this.TabBuilder(TAB_INDEX_3,
        $r('app.media.findIconNormal'),
        $r('app.media.findIconSelected'),
        $r('app.string.moment')));
    }
    .onChange((index: number) => {
      this.currentIndex = index;
      if (this.currentIndex === TAB_INDEX_0) {
        this.message = $r('app.string.chat');//聊天界面
      } else if (this.currentIndex === TAB_INDEX_1) {
        this.message = $r('app.string.contacts');// 联系人界面
      } else if (this.currentIndex === TAB_INDEX_2) {
        this.message = $r('app.string.LLM'); // 大语言界面
      } else if (this.currentIndex === TAB_INDEX_3) {
        this.message = $r('app.string.moment'); // 动态界面
      }
    })
    .barWidth($r('app.string.layout_100'))
    .barHeight($r('app.integer.tabbar_height'))
    .backgroundColor($r('app.color.tabbar_background'))
  }
  async aboutToAppear(){
    // main 在展现前就要和服务端建立websocket
    ws.connect(defaultIpAddress+this.uid, (err, value) => {
      if (!err) {
        console.log("Connected successfully");
      } else {
        console.log("Connection failed. Err:" + JSON.stringify(err));
      }
    });

    ws.on('close', (err, value) => {
      console.log("on close, code is " + value.code + ", reason is " + value.reason);
    });
    ws.on('error', (err) => {
      console.log("on error, error:" + JSON.stringify(err));
    });
  }

}

