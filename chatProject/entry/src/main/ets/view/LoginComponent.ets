import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { UserEntity } from '../stores/user';
import { ResponseResult } from '../utils/http/HttpCore';
import { HttpManager } from '../utils/http/HttpManager';
import { RequestMethod, RequestOptions } from '../utils/http/RequestOptions';

@Preview
@Component
export struct LoginComponent {
  @StorageProp('isMinHeight') isMinHeight: boolean = false;
  @State uid: string = '';
  @State password: string = '';
  @State uid_border_width: number = 0;
  rep = new RegExp("[0-9]{9}")

  // 登录UI状态
  @State loginState: number = 1;

  // 错误提示
  @State hint: string = '未定义';

  build() {
    Column() {
      // 图标
      Image($r('app.media.Huazi'))
        .width(80)
        .height(80)

      // 应用名称
      Text('MeetMe')
        .fontColor('#FF3B3A3A')
        .fontSize(26)
        .width(100)
        .fontStyle(FontStyle.Italic)
        .textAlign(TextAlign.Center)

      // UID输入框
      TextInput({ placeholder: 'UID' })
        .width(CommonConstants.TEXT_INPUT_WIDTH_PERCENT)
        .height($r('app.float.text_input_height'))
        .placeholderColor(Color.Gray)
        .placeholderFont({ size: $r('app.float.text_input_font_size') })
        .backgroundColor(Color.White)
        .fontSize($r('app.float.text_input_font_size'))
        // .padding({ left: $r('app.float.username_padding_left') })
        .margin({top: 36})
        .border({
          // width: { bottom: $r('app.float.input_border_width') },
          // color: $r('app.color.input_border_color'),
          radius: 8,
          width: this.uid_border_width,
          color: Color.Red
        })
        .onChange((value: string) => {
          this.uid = value;
          if (!this.rep.test(value)) {
            this.uid_border_width = 1;
            this.hint = "用户名应为9位数字"
          } else {
            this.uid_border_width = 0;
          }

        })

      if (this.loginState === 0) {
        Text()
          .height(14)
      } else {
        Text(this.hint)
          .fontColor(Color.Red)
          .fontSize(14)
          .width("100%")
          .height(14)
          .textAlign(TextAlign.Start)
          .padding({
            left: 6
          })
          .margin({
            top: 4
          })
      }

      // 密码输入框
      TextInput({ placeholder: '密码' })
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
          this.password = value;
        })

      Row() {
        // 登录按钮
        Button('登录', {type: ButtonType.Normal, stateEffect: true})
          .borderRadius(8)
          .fontSize(18)
          .backgroundColor('#317aff')
          .width('45%')
          .enabled(isLoginButtonClickable(this.uid, this.password))
          .onClick(() => {
            // ------------
            //创建一个RequestOptions对象，指定请求的URL、方法、请求头和要发送的数据
            // 根据uid登录
            const requestOptions: RequestOptions = {
              url: 'http://172.29.4.148:8080/v1/login',
              method: RequestMethod.POST,
              header: {
                'Content-Type': 'application/json',
              },
              extraData: JSON.stringify({
                uid: this.uid,
                password: this.password,
              }),
            };
            // // 调用HttpManager的request方法，发起POST请求
            HttpManager.getInstance().request<ResponseResult>(requestOptions)
              .then((result) => {
                console.info("login_:" + JSON.stringify(result.data));//输出用户信息并跳转
                if(result.code  == '200') {
                  // 成功登录
                  // let userentity: UserEntity = new UserEntity(JSON.parse(JSON.stringify(result.data))
                  //   .id, JSON.parse(JSON.stringify(result.data)).username, JSON.parse(JSON.stringify(result.data))
                  //   .password, JSON.parse(JSON.stringify(result.data)).uid);

                  globalThis.USERNAME = JSON.parse(JSON.stringify(result.data)).username;
                  console.info("login_:" + this.uid + globalThis.USERNAME)
                  globalThis.UID = this.uid;

                  router.pushUrl({
                    url: CommonConstants.MAIN_PAGE_URL
                    // params: {
                    //   uid: JSON.parse(JSON.stringify(result.data)).uid
                    // }
                  });
                }
              })
              .catch((err) => {
                console.error("login_:" + JSON.stringify(err));
              });

            // globalThis.UID = this.uid;
            //
            // router.pushUrl({
            //   url:CommonConstants.MAIN_PAGE_URL,
            //   params: {
            //     uid: 100000001
            //   }
            // });
          })

        // 注册按钮
        Button('注册', {type: ButtonType.Normal, stateEffect: true})
          .borderRadius(8)
          .backgroundColor(Color.Orange)
          .width('45%')
          // .backgroundColor('#FFFA0404')
          .fontSize(18)
          .onClick(() => {
            router.pushUrl({
              url: CommonConstants.REGISTER_PAGE_URL
            });
          })
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height('48vp')
      .margin({
        top: 30
      })
      .backgroundColor("#FFEAEAEA")
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}

/**
 * Calculate login button clickable by the input of username and password.
 *
 * @return {boolean} isLoginButtonClickable.
 */
function isLoginButtonClickable(userName: string, password: string): boolean {
  return userName !== '' && password !== '';
}
