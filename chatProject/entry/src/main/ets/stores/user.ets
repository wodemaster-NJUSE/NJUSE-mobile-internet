export class ResponseUserResult {
  /**
   * Code returned by the network request: success, fail.
   */
  code: string;

  /**
   * Message returned by the network request.
   */
  msg: string | Resource;

  /**
   * Data returned by the network request.
   */
  data: string | Object | ArrayBuffer;

  constructor() {
    this.code = '';
    this.msg = '';
    this.data = '';
  }
}
export class UserDataPost {
  username: string = '';
  password: string = '';

}
export class UserDataGet{
  id : Number ;
  username: string = '';
  password: string = '';
  uid : string = '';

  constructor(Id:Number,username:string,password:string,uid:string) {
    this.id = Id;
    this.username = username;
    this.password = password;
    this.uid = uid;
  }
}