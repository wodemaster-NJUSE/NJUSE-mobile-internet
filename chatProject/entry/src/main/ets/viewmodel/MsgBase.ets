/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import image from '@ohos.multimedia.image';
import { BasicDataSource } from './BasicDataSource';

/**
 * 聊天list中item对象
 * @param user 用户名
 * @param lastMsg 最后一天信息
 * @param time 时间
 */
@Observed
export class ChatModel {
  user: ChatContact
  lastMsg: string
  lastTime: string
  unreadMsgCount: number
  msgList:Array<MessageBase>
  constructor(user: ChatContact, lastMsg: string, lastTime: string, unreadMsgCount: number, msgs?:Array<MessageBase>) {
    this.user = user;
    this.lastMsg = lastMsg;
    this.lastTime = lastTime;
    this.unreadMsgCount = unreadMsgCount;
    this.msgList = msgs;
  }

  toString(): string {
    return this.user.toString() + '  ' + this.lastMsg;
  }
}

enum MsgType {
  TEXT = 1,
  IMAGE = 2,
  TEXT_AND_IMAGE = 3,
  NET_IMAGE = 4,
  LOADING_PROGRESS = 5
}

// 聊天信息
export class MessageBase {
  msgId: string
  from: ChatContact
  to: ChatContact
  msgBody: MessageBody
  msgType: MsgType
  msgTime: string = ''

  constructor(id: string, from: ChatContact, to: ChatContact, msg: MessageBody, type: number, time?: string) {
    this.msgId = id;
    this.from = from;
    this.to = to;
    this.msgBody = msg;
    this.msgType = type;
    if (time !== undefined) {
      this.msgTime = time;
    }
  }

  toString(): string {
    return this.msgId + '  ' + this.from + '  ' + this.to + '  ' + this.msgBody + '  ' + this.msgType + '  '
      + this.msgTime;
  }
}

export class MessageBody {
  toString(): string {
    return '';
  }
}

// 文本消息
export class TextMessage extends MessageBody {
  constructor(msg: string | Resource) {
    super();
    this.msg = msg;
  }

  msg: string | Resource
}

// 图片消息
export class ImageMessage extends MessageBody {
  toString(): string {
    return this.height + '  ' + this.width + '  ' + this.image;
  }

  constructor(height: number, width: number, image: string) {
    super();
    this.height = height;
    this.width = width;
    this.image = image;
  }

  height: number
  width: number
  image: string
}

// wantParams:图片+文本消息
export class ImageTextMessage extends MessageBody {
  toString(): string {
    return this.msg + ' ' +
    this.height + '  ' + this.width + '  ' + this.image;
  }

  constructor(height: number, width: number, image: string | Resource, msg: string) {
    super();
    this.height = height;
    this.width = width;
    this.image = image;
    this.msg = msg;
  }

  height: number
  width: number
  image: string | Resource
  msg: string
}

// wantParams:图片文件
export class FileMessage extends MessageBody {
  height: number | string
  width: number | string
  image: image.PixelMap

  constructor(height: number | string, width: number | string, image: image.PixelMap) {
    super();
    this.height = height;
    this.width = width;
    this.image = image;
  }
}

// contact
export class ChatContact {
  userId: string
  userName: string | Resource
  userImage: string | Resource

  toString(): string {
    return this.userId + '  ' + this.userName + '  ' + this.userImage;
  }

  constructor(id: string, name: string | Resource, image?: string | Resource) {
    this.userId = id;
    this.userName = name;
    this.userImage = $r('app.media.profile_photo_3');//还得拿到用户头像
    if (image != null) {
      this.userImage = image;
    }
  }
}

export class FriendMoment {
  id: string
  user: ChatContact
  text: string
  time: string = ''
  imageList: Array<string> = new Array<string>()
  media: string = '' // media为需要获取的视频url
  mediaPreview: string = '' //mediaPreview为需要获取的视频预览图url
 // likes : Number  // 点赞数

  constructor(id: string, user: ChatContact, text: string, time?: string, list?: Array<string>, media?: string, mediaPreview?: string) {
    this.id = id;
    this.user = user;
    if (time !== undefined) {
      this.time = time;
    }
    this.text = text;
    if (list !== undefined && list.length) {
      this.imageList = list;
    }
    else if (media) {
      this.media = media;
      if (mediaPreview !== undefined) {
        this.mediaPreview = mediaPreview;
      }
    }
  }

  toString(): string {
    return this.id + '  ' + this.user.toString() + '  ' + this.text + '  ' + this.time;
  }
}

export class ChatDetailData extends BasicDataSource<MessageBase> {
  msgList: Array<MessageBase> = [];

  public totalCount(): number {
    return this.msgList.length;
  }

  public getData(index: number): MessageBase {
    return this.msgList[index];
  }

  public addData(index: number, data: MessageBase): void {
    this.msgList.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: MessageBase): void {
    this.msgList.push(data);
    this.notifyDataAdd(this.msgList.length - 1);
  }

  /**
   * added by 陈凌
   * 删除数据、更改数据、恢复数据
   */
  public deleteData(index: number): void {
    this.msgList.splice(index, 1);
    this.notifyDataDelete(index);
  }

  public changeData(index: number, data: MessageBase): void {
    this.msgList.splice(index, 1, data);
    this.notifyDataChange(index);
  }

  public reloadData(): void {
    this.notifyDataReload();
  }
}