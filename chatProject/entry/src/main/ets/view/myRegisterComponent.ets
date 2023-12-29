import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { User } from '../model/UserModel';


import { HttpManager } from '../utils/http/HttpManager';
//import { RequestMethod, RequestOptions } from '../utils/http/RequestOptions';
import http from '@ohos.net.http';
import { RequestMethod, RequestOptions } from '../utils/http/RequestOptions';
import { ResponseResult } from '../utils/http/HttpCore';

@Component
export struct myRegisterComponent {
  @State userName: string = '';
  @State passWord: string = '';
  @State repeatPWD: string = '';
  @State isCorrect: boolean = false;

  build() {
    Column() {
      Text('欢迎注册MeetMe')
    }
  }
}