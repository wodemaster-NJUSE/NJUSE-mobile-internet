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
        .width('100%')
        .fontColor(Color.Black)
        .fontSize(26)
        .textAlign(TextAlign.Start)

      Text('遇见，每一天')
        .width('100%')
        .fontColor(Color.Black)
        .fontSize(18)
        .textAlign(TextAlign.Start)
        .margin({
          top: 4
        })

      TextInput({ placeholder: '用户名' })
        .width(CommonConstants.TEXT_INPUT_WIDTH_PERCENT)
        .height($r('app.float.text_input_height'))
        .placeholderColor(Color.Gray)
        .placeholderFont({ size: $r('app.float.text_input_font_size') })
        .backgroundColor(Color.White)
        .fontSize($r('app.float.text_input_font_size'))
          // .padding({ left: $r('app.float.username_padding_left') })
        .margin({top: 12})
        .border({
          // width: { bottom: $r('app.float.input_border_width') },
          // color: $r('app.color.input_border_color'),
          radius: 8
        })

      TextInput({ placeholder: $r('app.string.password') })
        .width(CommonConstants.TEXT_INPUT_WIDTH_PERCENT)
        .height($r('app.float.text_input_height'))
        .placeholderColor($r('app.color.text_input_place_holder'))
        .placeholderFont({ size: $r('app.float.text_input_font_size') })
        .fontSize($r('app.float.text_input_font_size'))
        .backgroundColor(Color.White)
        .type(InputType.Password)
        .border({
          // width: { bottom: $r('app.float.input_border_width') },
          // color: $r('app.color.input_border_color'),
          radius: 8
        })
        .margin({ top: 20 })

      TextInput({ placeholder: '再次输入密码' })
        .width(CommonConstants.TEXT_INPUT_WIDTH_PERCENT)
        .height($r('app.float.text_input_height'))
        .placeholderColor($r('app.color.text_input_place_holder'))
        .placeholderFont({ size: $r('app.float.text_input_font_size') })
        .fontSize($r('app.float.text_input_font_size'))
        .backgroundColor(Color.White)
        .type(InputType.Password)
        .border({
          // width: { bottom: $r('app.float.input_border_width') },
          // color: $r('app.color.input_border_color'),
          radius: 8
        })
        .margin({ top: 20 })

      Button('立即注册', {type: ButtonType.Normal, stateEffect: true})
        .borderRadius(8)
        .backgroundColor(Color.Orange)
        .width('100%')
          // .backgroundColor('#FFFA0404')
        .fontSize(18)
        .margin({
          top: 20
        })


    }
  }
}

function isLoginButtonClickable(userName: string, password: string): boolean {
  return userName !== '' && password !== '';
}