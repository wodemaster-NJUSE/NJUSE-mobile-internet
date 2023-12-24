import { BasicDataSource } from './BasicDataSource'
import { ContactModel } from './ContactBase'
import Logger from '../utils/Logger'

// TODO-暂时弃用

const TAG: string = 'ContactsList_Data'

export class ContactsListData extends BasicDataSource<ContactModel> {
  private contactsList: Array<ContactModel> = []

  public totalCount(): number {
    return this.contactsList.length
  }

  public getData(index: number): ContactModel {
    Logger.info(TAG, 'getData, index=' + index)
    return this.contactsList[index]
  }

  public addData(index: number, data: ContactModel): void {
    this.contactsList.splice(index, 0, data)
    this.notifyDataAdd(index)
  }

  public pushData(data: ContactModel): void {
    this.contactsList.push(data)
    this.notifyDataAdd(this.contactsList.length - 1)
  }
  // 查找列表中对象的index
  public indexOf(data: ContactModel): number {
    Logger.info(TAG, `indexOf data , id = ${data.userId} , name = ${data.userName}`);
    return this.contactsList.indexOf(data);
  }
  // 删除列表中处于index位置的对象
  public deleteDataByIndex(index: number): void {
    Logger.info(TAG, `delete data , index = ${index}}`);
    this.contactsList.splice(index, 1);
    this.notifyDataDelete(index);
  }
  // 删除列表中的对象
  public deleteData(data: ContactModel): void {
    Logger.info(TAG, `delete data , data = ${data.userId}}`);
    let index = this.indexOf(data);
    this.deleteDataByIndex(index);
  }
}