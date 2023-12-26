import List from '@ohos.util.List';
import FriendMomentJsonUrl from '../utils/FriendMomentJsonUrl';
import { ChatModel, FriendMoment } from '../viewmodel/MsgBase';
import image from '@ohos.multimedia.image';

export class UserDataPost {
  username: string = '';
  password: string = '';
}
export class UserEntity{
  id : Number ;
  username: string = '';
  password: string = '';
  uid: string = '';
  photo : string = '';// url加载图片
  //动态列表 构建动态类
  // friendsMomentsList : Array<FriendMoment> = [] ;
  // //聊天列表 构建聊天类，点击头像可以进入聊天详情
  // chatsModelList :  Array<ChatModel> = [] ;
  //构建单个聊天细节界面

  //联系人列表 构建联系人列表，联系人信息
  //contacts : List<>
  constructor(id:Number,username:string,password:string,uid:string) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.uid = uid;
  }
}
