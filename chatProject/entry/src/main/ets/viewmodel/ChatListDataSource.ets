import { BasicDataSource } from './BasicDataSource'
import { ChatModel } from './MsgBase'
import Logger from '../utils/Logger'

const TAG: string = 'ChatList_Data'

export class ChatListData extends BasicDataSource<ChatModel> {
  chatList: Array<ChatModel> = []

  public totalCount(): number {
    return this.chatList.length
  }

  public getData(index: number): ChatModel {
    Logger.info(TAG, 'getData, index=' + index)
    return this.chatList[index]
  }

  public addData(index: number, data: ChatModel): void {
    this.chatList.splice(index, 0, data)
    this.notifyDataAdd(index)
  }

  public pushData(data: ChatModel): void {
    this.chatList.push(data)
    this.notifyDataAdd(this.chatList.length - 1)
  }
  // 查找列表中对象的index
  public indexOf(data: ChatModel): number {
    Logger.info(TAG, `indexOf data , id = ${data.user.userId} , name = ${data.user.userName}`);
    return this.chatList.indexOf(data);
  }
  // 删除列表中处于index位置的对象
  public deleteDataByIndex(index: number): void {
    Logger.info(TAG, `delete data , index = ${index}}`);
    this.chatList.splice(index, 1);
    this.notifyDataDelete(index);
  }
  // 删除列表中的对象
  public deleteData(data: ChatModel): void {
    Logger.info(TAG, `delete data , data = ${data.user.userId}}`);
    let index = this.indexOf(data);
    this.deleteDataByIndex(index);
  }
}