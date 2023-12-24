import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { User } from '../model/UserModel';
import { UserDataGet } from '../stores/user';

import { HttpManager } from '../utils/http/HttpManager';
//import { RequestMethod, RequestOptions } from '../utils/http/RequestOptions';
import http from '@ohos.net.http';
import { RequestMethod, RequestOptions } from '../utils/http/RequestOptions';
import { ResponseResult } from '../utils/http/HttpCore';

//import { httpRequestGetUser, httpRequestPostUser } from '../utils/UserHttpUtil';

@Component
//未标准化
export struct RegisterComponent {
  @State userName :string = '';
  @State passWord :string = '';
  @State repeatPWD:string = '';
  @State isCorrect: boolean =false;

  //获取用户名和密码
  build() {
    GridRow({
      columns: {
        sm: CommonConstants.GRID_ROW_SM,
        md: CommonConstants.GRID_ROW_MD,
        lg: CommonConstants.GRID_ROW_LG
      },
      gutter: { x: CommonConstants.GUTTER_X },
      breakpoints: { value: CommonConstants.BREAK_POINT }
    }) {
      GridCol({
        span: {
          sm: CommonConstants.SPAN_SM,
          md: CommonConstants.SPAN_MD,
          lg: CommonConstants.SPAN_LG
        },
        offset: {
          sm: CommonConstants.OFFSET_SM,
          md: CommonConstants.OFFSET_MD,
          lg: CommonConstants.OFFSET_LG
        }
      }) {
        Column() {
          Row() {
            Text("用户名")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
          }.width("100%")
          TextInput({ placeholder: $r('app.string.username') })
            .width(CommonConstants.TEXT_INPUT_WIDTH_PERCENT)
            .height($r('app.float.text_input_height'))
            .placeholderColor($r('app.color.text_input_place_holder'))
            .placeholderFont({ size: $r('app.float.text_input_font_size') })
            .backgroundColor($r('app.color.login_input_text_background'))
            .fontSize($r('app.float.text_input_font_size'))
            .padding({ left: $r('app.float.username_padding_left') })
            .border({
              width: { bottom: $r('app.float.input_border_width') },
              color: $r('app.color.input_border_color'),
              radius: $r('app.float.input_border_radius')
            }).margin({ bottom: $r('app.float.input_margin_bottom') })
            .onChange((value: string) => {
              this.userName = value;
            })


          Row() {
            Text("密码")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
          }.width("100%")
          TextInput({ placeholder: $r('app.string.password') })
            .width(CommonConstants.TEXT_INPUT_WIDTH_PERCENT)
            .height($r('app.float.text_input_height'))
            .placeholderColor($r('app.color.text_input_place_holder'))
            .placeholderFont({ size: $r('app.float.text_input_font_size') })
            .fontSize($r('app.float.text_input_font_size'))
            .backgroundColor($r('app.color.login_input_text_background'))
            .type(InputType.Password)
            .padding({ left: $r('app.float.password_padding_left') })
            .border({
              width: { bottom: $r('app.float.input_border_width') },
              color: $r('app.color.input_border_color'),
              radius: $r('app.float.input_border_radius')
            })
            .margin({ bottom: $r('app.float.input_margin_bottom') })
            .onChange((value: string) => {
              this.passWord = value;
            })


          Row() {
            Text("再次输入密码")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
          }.width("100%")
          TextInput({ placeholder: "请再次输入密码" })
            .width(CommonConstants.TEXT_INPUT_WIDTH_PERCENT)
            .height($r('app.float.text_input_height'))
            .placeholderColor($r('app.color.text_input_place_holder'))
            .placeholderFont({ size: $r('app.float.text_input_font_size') })
            .fontSize($r('app.float.text_input_font_size'))
            .backgroundColor($r('app.color.login_input_text_background'))
            .type(InputType.Password)
            .padding({ left: $r('app.float.password_padding_left') })
            .border({
              width: { bottom: $r('app.float.input_border_width') },
              color: $r('app.color.input_border_color'),
              radius: $r('app.float.input_border_radius')
            })
            .margin({ bottom: $r('app.float.input_margin_bottom') })
            .onChange((value: string) => {
              this.repeatPWD = value;
            })

          Button("注册")
            .width(CommonConstants.BUTTON_WIDTH_PERCENT)
            .height($r('app.float.login_btn_height'))
            .borderRadius($r('app.float.login_btn_border_radius'))
            .fontSize($r('app.float.text_input_font_size'))
            .margin({ top: $r('app.float.register_btn_margin_top') })
            .fontWeight(CommonConstants.LOGIN_TEXT_FONT_WEIGHT)
            .enabled(isRegisterButtonClickable(this.userName, this.passWord,this.repeatPWD))
            .fontColor(isRegisterButtonClickable(this.userName, this.passWord,this.repeatPWD) ?
            Color.White : $r('app.color.login_font_normal'))
            .backgroundColor(isRegisterButtonClickable(this.userName, this.passWord,this.repeatPWD) ?
            $r('app.color.login_btn_enabled') : $r('app.color.login_btn_normal'))
            .onClick(() => {
              // 创建一个RequestOptions对象，指定请求的URL、方法、请求头和要发送的数据
             let user1 : UserDataGet;//接收传过来的数据

              const requestOptions: RequestOptions = {
                url: "http://172.29.4.148:8080/v1/user",
                method: RequestMethod.POST,
                header: {
                  'Content-Type': 'application/json'
                },
                extraData: {
                  "username":"user1",
                  "password":"Ab12345678"
                }
              };

              // 调用HttpManager的request方法，发起POST请求
              HttpManager.getInstance().request<ResponseResult>(requestOptions)
                .then((result) => {
                  console.info(JSON.stringify(result.data));//输出用户信息并跳转

                  router.pushUrl({
                    url: CommonConstants.REGISTRATION_SUCCESS_PAGE_URL,
                    params :{
                      uid : JSON.parse(JSON.stringify(result.data)).uid
                    }
                  });
                })
                .catch((err) => {
                  console.error(JSON.stringify(err));
                });


            })

        }
      }
    }
    //对用户属性进行处理，并且进行界面跳转，符合就跳转到成功界面，失败界面提示
  }
}
function isRegisterButtonClickable(userName: string, password: string, repeatPWD:string): boolean {
  return userName !== '' && password !== '' && repeatPWD !== '';
}

