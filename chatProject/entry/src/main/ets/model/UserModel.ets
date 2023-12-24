
/**
 * 用户类在前端的模型
 * 引用方法： import {User} from 'ets/model/UserModel'
 */
export class User {

  // 用户头像
  profilePicture : Resource = $r('app.media.profilePicture01')

  // 用户名
  userName : string = "李四"

  // 用户签名
  signature : string = "李四吃饱了"

  // 用户性别
  gender : string = "性别数量，超越你的想象"

  // 若有开发需要，请自行增加属性

  // 构造函数
  constructor(profilePicture = $r('app.media.profilePicture01'),
              userName : string = "李四",
              signature : string = "李四吃饱了",
              gender : string = "性别数量，超越你的想象")
  {
    this.profilePicture = profilePicture
    this.userName = userName
    this.signature = signature
    this.gender = gender
  }

  setUserName(userName : string) {
    this.userName = userName
  }
}