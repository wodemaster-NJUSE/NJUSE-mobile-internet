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
import { CommonConstants } from '../common/constants/CommonConstants';
import router from '@ohos.router';

// import { CustomDialogExample } from './CustomDialogExample';

// 右上角+号按钮的ID
const ID_ADD_BUTTON: string = "addBtn";
// 点击右上角+号按钮，弹出的弹窗的X轴偏移量
const DIALOG_CONTROLLER_OFFSET_X: number = -15;
// 点击右上角+号按钮，弹出的弹窗的Y轴偏移量
const DIALOG_CONTROLLER_OFFSET_Y: number = 110;
// 点击右上角+号按钮，弹窗弹出后，点击遮罩区域，弹窗能否自动消失
const DIALOG_CONTROLLER_AUTO_CANCEL: boolean = true;
// 点击右上角+号按钮，弹出的弹窗容器样式是否自定义
const DIALOG_CONTROLLER_CUSTOM_STYLE: boolean = true;

@Component
export struct TopBar {
  build() {
    TopBar() {
      Row() {
        Image($r('app.media.ic_back'))
          .width($r('app.float.image_size'))
          .height($r('app.float.image_size'))
          .margin({
            left: $r('app.float.image_margin_left'),
            right: $r('app.float.image_margin_right')
          })
          .onClick(() => {
            router.back();
          })

        Text($r('app.string.mine_page_title'))
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.title'))
          .fontWeight(CommonConstants.TITLE_FONT_WEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height($r('app.float.title_height'))
    }
  }
}