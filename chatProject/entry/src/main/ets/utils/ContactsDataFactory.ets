import hiTraceMeter from '@ohos.hiTraceMeter';
import util from '@ohos.util';
import Logger from './Logger';
import { ContactModel } from '../viewmodel/ContactBase'
import { ContactsListData } from  '../viewmodel/ContactsListDataSource'
import Constants from './Constants';
import { ChatModel, FriendMoment } from '../viewmodel/MsgBase';

// TODO-暂时弃用


const TAG: string = 'ContactsList_DataFactory';
const MOCK_DATA_FILE_DIR: string = 'mockChatModelData.json';
const MAKE_DATA_LOCAL_TRACE: string = 'ContactsList_MakeDataLocal_HiTrace';
const MAKE_DATA_LOCAL_TRACE_ID: number = 1; // makeDataLocal 中使用的 taskId
const MAKE_DATA_LIST_TRACE: string = 'ContactsList_MakeDataList_HiTrace';
const MAKE_DATA_LIST_TRACE_ID: number = 2; // makeDataList 中使用的 taskId

// class JsonObjType {
//   ChatModel: Array<ChatModel> = new Array<ChatModel>();
//   ContactModel: Array<ContactModel> = new Array<ContactModel>();
// }

class JsonObjType {
  MessageList: Array<string> = new Array<string>();
  ChatModel: Array<ChatModel> = new Array<ChatModel>();
  FriendMoment: Array<FriendMoment> = new Array<FriendMoment>();
}

/**
 * 加载联系人列表数据到参数传入的懒加载数据列表中
 * @param listData 懒加载数据列表
 */
export async function makeDataLocal(listData: ContactsListData): Promise<void> {
  Logger.info(TAG, 'makeDataLocal');
  hiTraceMeter.startTrace(MAKE_DATA_LOCAL_TRACE, MAKE_DATA_LOCAL_TRACE_ID);
  let contactModelMockData = await getContactModelObjFromJSON();
  for (let i = 0; i < Constants.DATA_MOCK_COUNT; i++) {
    listData.pushData(contactModelMockData[i]);
  }
  hiTraceMeter.finishTrace(MAKE_DATA_LOCAL_TRACE, MAKE_DATA_LOCAL_TRACE_ID);
}

/**
 * 加载联系人列表数据，到参数传入的数据列表中
 * @param listData 普通数据列表
 */
export async function makeDataList(listData: Array<ContactModel>): Promise<void> {
  Logger.info(TAG, 'makeDataList');
  hiTraceMeter.startTrace(MAKE_DATA_LIST_TRACE, MAKE_DATA_LIST_TRACE_ID);
  let contactModelMockData = await getContactModelObjFromJSON();
  for (let i = 0; i < Constants.DATA_MOCK_COUNT; i++) {
    listData.push(contactModelMockData[i]);
  }
  hiTraceMeter.finishTrace(MAKE_DATA_LIST_TRACE, MAKE_DATA_LIST_TRACE_ID);
}

/**
 * 获取ContactModel的模拟数据列表
 */
export async function getContactModelObjFromJSON(): Promise<Array<ContactModel>> {
  Logger.info(TAG, 'getContactModelObjFromJSON');
  let jsonObj: JsonObject = new JsonObject(MOCK_DATA_FILE_DIR);
  return await jsonObj.getContactModelObj();
}

class JsonObject {
  private jsonFileDir: string = '';

  constructor(jsonFileDir: string) {
    this.jsonFileDir = jsonFileDir;
  }

  async getContactModelObj(): Promise<Array<ContactModel>> {
    let value = await getContext().resourceManager.getRawFileContent(this.jsonFileDir);
    let jsonObj: JsonObjType = JSON.parse(this.bufferToString(value.buffer)) as JsonObjType;
    let contactModelBuckets: Array<ContactModel> = new Array<ContactModel>();
    // if (jsonObj.ContactModel === undefined) {
    //   Logger.error(TAG + '_getContactModelObjFromJSON', 'Expected ContactModel field in json, but not found');
    //   return contactModelBuckets;
    // }
    if (jsonObj.ChatModel === undefined) {
      Logger.error(TAG + '_getChatModelObjFromJSON', 'Expected ChatModel field in json, but not found');
      return contactModelBuckets;
    }
    // 映射json数据为ContactModel对象
    // let contactModelObj = jsonObj.ContactModel;
    let chatModelObj = jsonObj.ChatModel;
    for (let i = 0; i < chatModelObj.length; i++) {
      let contactModelTemp = new ContactModel(chatModelObj[i].user.userId, chatModelObj[i].user.userName,
        chatModelObj[i].user.userImage);
      contactModelBuckets.push(contactModelTemp);
    }
    return contactModelBuckets;
  }

  private bufferToString(buffer: ArrayBuffer): string {
    Logger.info(TAG, 'bufferToString');
    let textDecoder = util.TextDecoder.create('utf-8', {
      ignoreBOM: true
    });
    let resultPut = textDecoder.decodeWithStream(new Uint8Array(buffer), {
      stream: true
    });
    return resultPut;
  }
}