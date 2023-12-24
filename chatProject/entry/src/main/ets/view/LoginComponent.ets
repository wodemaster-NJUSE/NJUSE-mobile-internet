import router from '@ohos.router';
import { CommonConstants } from '../common/constants/CommonConstants';
import { UserDataGet, UserDataPost } from '../stores/user';
import { HttpManager } from '../utils/http/HttpManager';
//import { RequestMethod, RequestOptions } from '../utils/http/RequestOptions';
import http from '@ohos.net.http';
import { RequestMethod, RequestOptions } from '../utils/http/RequestOptions';

/**
 * Login page component.
 */
@Component
export struct LoginComponent {
  @StorageProp('isMinHeight') isMinHeight: boolean = false;
  @State userName: string = '';
  @State password: string = '';


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
              this.password = value;
            })
        }
      }

      GridCol({
        span: {
          sm: CommonConstants.BUTTON_SPAN_SM,
          md: this.isMinHeight ? CommonConstants.BUTTON_SPAN_MD_SMALL : CommonConstants.BUTTON_SPAN_MD_BIG,
          lg: CommonConstants.BUTTON_SPAN_LG
        },
        offset: {
          sm: CommonConstants.BUTTON_OFFSET_SM,
          md: CommonConstants.BUTTON_OFFSET_MD,
          lg: CommonConstants.BUTTON_OFFSET_LG
        }
      }) {
        Button($r('app.string.login'))
          .width(CommonConstants.BUTTON_WIDTH_PERCENT)
          .height($r('app.float.login_btn_height'))
          .borderRadius($r('app.float.login_btn_border_radius'))
          .fontSize($r('app.float.text_input_font_size'))
          .margin({ top: $r('app.float.register_btn_margin_top') })
          .fontWeight(CommonConstants.LOGIN_TEXT_FONT_WEIGHT)
          .enabled(isLoginButtonClickable(this.userName, this.password))
          .fontColor(isLoginButtonClickable(this.userName, this.password) ?
            Color.White : $r('app.color.login_font_normal'))
          .backgroundColor(isLoginButtonClickable(this.userName, this.password) ?
            $r('app.color.login_btn_enabled') : $r('app.color.login_btn_normal'))
          .onClick(() => {
            // // 创建一个实例
            // const httpManager = HttpManager.getInstance();
            //
            // // 构造注册请求数据
            // const registerData = {
            //   username: this.userName,
            //   password: this.password,
            //   // 其他字段
            // };
            //
            // // 构造注册请求选项
            // const registerRequestOptions: RequestOptions = {
            //   url: 'http://172.29.4.148:8080/v1/user', // 假设这是注册接口的URL
            //   method: RequestMethod.POST,
            //   extraData: JSON.stringify(registerData), // 将注册数据转为字符串
            //   header: {
            //     'Content-Type': 'application/json', // 设置请求头
            //   },
            // };
            //
            // // 发送注册请求
            // httpManager.request<UserDataGet>(registerRequestOptions)
            //   .then((userData: UserDataGet) => {
            //     // 处理返回的 userData
            //     console.log('注册成功', userData);
            //   })
            //   .catch((error: Error) => {
            //     // 处理错误
            //     console.error('注册失败', error);
            //   });

            //创建一个RequestOptions对象，指定请求的URL、方法、请求头和要发送的数据
            let user1: UserDataGet; // 接收传过来的数据
            const requestOptions: RequestOptions = {
              url: 'http://172.29.4.148:8080/v1/user',
              method: RequestMethod.POST,
              header: {
                'Content-Type': 'application/json',
              },
              extraData: JSON.stringify({
                username: 'user1',
                password: 'Ab1234567',
              }),
            };

            // 调用HttpManager的request方法，发起POST请求
            HttpManager.getInstance()
              .request<UserDataGet>(requestOptions)
              .then((result) => {
                console.info(JSON.stringify(result)); // 输出用户信息并跳转

                // 构造用户对象并跳转
                user1 = new UserDataGet(result.id, result.username, result.password, result.uid);

                // 确保在请求成功后再跳转
                router.pushUrl({
                  url: CommonConstants.MAIN_PAGE_URL,
                  params:{
                    // 把用户实体传过去
                  }
                });
              })
              .catch((err) => {
                console.error('Error during registration:', JSON.stringify(err));
                // 在此处可以添加更多错误处理逻辑，例如向用户显示错误信息
                // 输出服务端返回的详细错误信息
                if (err.response) {
                  console.error('Server Response:', JSON.stringify(err.response));
                }
              });



            // router.pushUrl({
            //   url:CommonConstants.MAIN_PAGE_URL
            // });
          })
      }

      GridCol({
        span: {
          sm: CommonConstants.BUTTON_SPAN_SM,
          md: this.isMinHeight ? CommonConstants.BUTTON_SPAN_MD_SMALL : CommonConstants.BUTTON_SPAN_MD_BIG,
          lg: CommonConstants.BUTTON_SPAN_LG
        },
        offset: {
          sm: CommonConstants.BUTTON_OFFSET_SM,
          md: this.isMinHeight ? CommonConstants.BUTTON_OFFSET_SM : CommonConstants.BUTTON_OFFSET_MD,
          lg: CommonConstants.BUTTON_OFFSET_LG
        }
      }) {
        Button($r('app.string.register'))
          .width(CommonConstants.BUTTON_WIDTH_PERCENT)
          .height($r('app.float.login_btn_height'))
          .fontSize($r('app.float.text_input_font_size'))
          .fontWeight(CommonConstants.BUTTON_FONT_WEIGHT)
          .borderRadius($r('app.float.register_btn_border_radius'))
          .margin({ top: $r('app.float.register_btn_margin_top') })
          .fontColor($r('app.color.register_font_clickable'))
          .backgroundColor($r('app.color.register_btn_clickable'))
          .onClick(() => {
            router.pushUrl({
              url: CommonConstants.REGISTER_PAGE_URL
            });
          })
      }
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

