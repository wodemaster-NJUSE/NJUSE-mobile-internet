import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { HttpManager } from '../utils/http/HttpManager';
import { RequestMethod, RequestOptions } from '../utils/http/RequestOptions';
import { ResponseResult } from '../utils/http/HttpCore';
import Logger from '../utils/Logger';

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
        .onChange((value: string) => {
          this.userName = value;
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
        .onChange((value: string) => {
          this.passWord = value;
        })

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
        .onChange((value: string) => {
          this.repeatPWD = value;
        })

      Button('立即注册', {type: ButtonType.Normal, stateEffect: true})
        .borderRadius(8)
        .backgroundColor(Color.Orange)
        .width('100%')
          // .backgroundColor('#FFFA0404')
        .fontSize(18)
        .margin({
          top: 20
        })
        .enabled(isRegisterButtonClickable(this.userName, this.passWord,this.repeatPWD))
        .onClick(() => {
          console.info("fuck Huazi");

          // 创建一个RequestOptions对象，指定请求的URL、方法、请求头和要发送的数据
          const requestOptions: RequestOptions = {
            url: "http://172.29.4.148:8080/v1/register",
            method: RequestMethod.POST,
            header: {
              'Content-Type': 'application/json'
            },
            extraData: {
              "username": this.userName,
              "password": this.passWord
            }
          };

          // 调用HttpManager的request方法，发起POST请求
          HttpManager.getInstance().request<ResponseResult>(requestOptions)
            .then((result) => {
              console.info("fuck Huazi");
              console.info(JSON.stringify(result.data));//输出用户信息并跳转

              router.pushUrl({
                url: CommonConstants.REGISTRATION_SUCCESS_PAGE_URL,
                params :{
                  // uid : JSON.parse(JSON.stringify(result.data)).uid  //只需要获取一个uid即可
                  uid : '1000001'
                }
              });
            })
            .catch((err) => {
              Logger.error(`fuck reg ${err}`);
            });
        })
    }
  }
}

function isRegisterButtonClickable(userName: string, password: string, repeatPWD:string): boolean {
  return userName !== '' && password !== '' && repeatPWD !== '';
}