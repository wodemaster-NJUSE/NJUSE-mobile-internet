/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

export class ButtonInfoModel {
  index: number = 0;
  img: Resource = $r("app.media.message");
  selectImg: Resource = $r("app.media.message");//TODO :应该设置为选中的图标
  title: Resource = $r('app.string.message');
}

const buttonInfo: ButtonInfoModel[] = [
  {
    index: 0,
    img: $r("app.media.message"),
    selectImg: $r("app.media.message"),
    title: $r('app.string.message')
  },
  {
    index: 1,
    img: $r('app.media.LLM'),
    selectImg: $r('app.media.LLM'),//TODO :应该设置为选中的图标
    title: $r('app.string.LLM')
  },
  {
    index: 2,
    img: $r("app.media.contacts_"),
    selectImg: $r("app.media.contacts_"),//TODO :应该设置为选中的图标
    title: $r('app.string.contacts')
  },
  {
    index: 3,
    img: $r('app.media.moment'),
    selectImg: $r('app.media.moment'),
    title: $r('app.string.moment')
  }
]

export { buttonInfo }