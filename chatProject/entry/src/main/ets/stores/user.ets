export class UserDataPost {
  username: string = '';
  password: string = '';

}
export class UserDataGet{
  id : Number ;
  username: string = '';
  password: string = '';
  uid: string = '';

  constructor(Id:Number,username:string,password:string,uid:string) {
    this.id = Id;
    this.username = username;
    this.password = password;
    this.uid = uid;
  }
}
