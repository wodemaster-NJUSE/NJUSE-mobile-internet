import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';

@Preview
@Component
export struct LoginComponent {
  @StorageProp('isMinHeight') isMinHeight: boolean = false;
  @State uid: string = '';
  @State password: string = '';

  build() {
    Column() {
      Image($r('app.media.Huazi'))
        .width(80)
        .height(80)

      Text('MeetMe')
        .fontColor('#FF3B3A3A')
        .fontSize(26)
        .width(100)
        .fontStyle(FontStyle.Italic)
        .textAlign(TextAlign.Center)

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
          radius: 8
        })
        .onChange((value: string) => {
          this.uid = value;
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
          this.password = value;
        })

      Row() {

        Button('登录', {type: ButtonType.Normal, stateEffect: true})
          .borderRadius(8)
          .fontSize(18)
          .backgroundColor('#317aff')
          .width('45%')
          .enabled(isLoginButtonClickable(this.uid, this.password))
          .onClick(() => {
            // // ------------
            // //创建一个RequestOptions对象，指定请求的URL、方法、请求头和要发送的数据
            // // 根据uid登录
            // const requestOptions: RequestOptions = {
            //   url: 'http://172.29.4.148:8080/v1/login',
            //   method: RequestMethod.POST,
            //   header: {
            //     'Content-Type': 'application/json',
            //   },
            //   extraData: JSON.stringify({
            //     uid: this.uid,
            //     password: this.password,
            //   }),
            // };
            // // // 调用HttpManager的request方法，发起POST请求
            // HttpManager.getInstance().request<ResponseResult>(requestOptions)
            //   .then((result) => {
            //     console.info(JSON.stringify(result.data));//输出用户信息并跳转
            //     if(result.code  == '200') {
            //       // 成功登录
            //       let userentity: UserEntity = new UserEntity(JSON.parse(JSON.stringify(result.data))
            //         .id, JSON.parse(JSON.stringify(result.data)).username, JSON.parse(JSON.stringify(result.data))
            //         .password, JSON.parse(JSON.stringify(result.data)).uid);
            //
            //       router.pushUrl({
            //         url: CommonConstants.MAIN_PAGE_URL,
            //         params: {
            //           uid: JSON.parse(JSON.stringify(result.data)).uid
            //         }
            //
            //       });
            //     }
            //   })
            //   .catch((err) => {
            //     console.error(JSON.stringify(err));
            //   });

            globalThis.UID = this.uid;

            router.pushUrl({
              url:CommonConstants.MAIN_PAGE_URL,
              params: {
                uid: 10001
              }
            });
          })

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
        top: 20
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
