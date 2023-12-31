/**
 * Common Constants for all features.
 */
export class CommonConstants {
  /**
   * The number of columns for SM device.
   */
  static readonly GRID_ROW_SM: number = 4;

  /**
   * The number of columns for MD device.
   */
  static readonly GRID_ROW_MD: number = 8;

  /**
   * The number of columns for LG device.
   */
  static readonly GRID_ROW_LG: number = 12;

  /**
   * The gutter of x direction device.
   */
  static readonly GUTTER_X: number = vp2px(12);

  /**
   * The span of page for SM device.
   */
  static readonly SPAN_SM: number = 4;

  /**
   * The span of page for MD device.
   */
  static readonly SPAN_MD: number = 6;

  /**
   * The span of page for MD device.
   */
  static readonly SPAN_LG: number = 8;

  /**
   * The span of privacy statement for SM device.
   */
  static readonly PRIVACY_SPAN_SM: number = 2;

  /**
   * The span of privacy statement for MD device.
   */
  static readonly PRIVACY_SPAN_MD: number = 4;

  /**
   * The span of privacy statement for LG device.
   */
  static readonly PRIVACY_SPAN_LG: number = 4;

  /**
   * The span of mine page for SM device.
   */
  static readonly MINE_SPAN_SM: number = 4;

  /**
   * The span of mine page for MD device.
   */
  static readonly MINE_SPAN_MD: number = 8;

  /**
   * The span of mine for LG device.
   */
  static readonly MINE_SPAN_LG: number = 8;

  /**
   * The span of login component button for SM device.
   */
  static readonly BUTTON_SPAN_SM: number = 4;

  /**
   * The span of login component button for MD device if break point is smaller than 360vp.
   */
  static readonly BUTTON_SPAN_MD_SMALL: number = 3;

  /**
   * The span of login component button for MD device if break point is not smaller than 360vp.
   */
  static readonly BUTTON_SPAN_MD_BIG: number = 6;

  /**
   * The span of login component button for LG device.
   */
  static readonly BUTTON_SPAN_LG: number = 8;

  /**
   * The offset for SM device.
   */
  static readonly OFFSET_SM: number = 1;

  /**
   * The offset for MD device.
   */
  static readonly OFFSET_MD: number = 1;

  /**
   * The offset for LG device.
   */
  static readonly OFFSET_LG: number = 2;

  /**
   * The offset of privacy statement component for SM device.
   */
  static readonly PRIVACY_OFFSET_SM: number = 1;

  /**
   * The offset of privacy statement component for MD device.
   */
  static readonly PRIVACY_OFFSET_MD: number = 2;

  /**
   * The offset of privacy statement component for LG device.
   */
  static readonly PRIVACY_OFFSET_LG: number = 4;

  /**
   * The offset of login component button for SM device.
   */
  static readonly BUTTON_OFFSET_SM: number = 0;

  /**
   * The offset of login component button for MD device.
   */
  static readonly BUTTON_OFFSET_MD: number = 2;

  /**
   * The offset of login component button for LG device.
   */
  static readonly BUTTON_OFFSET_LG: number = 4;

  /**
   * The break point for page.
   */
  static readonly BREAK_POINT: Array<string> = ['320vp', '600vp', '820vp'];

  /**
   * Login scroll layout weight.
   */
  static readonly LOGIN_SCROLL_LAYOUT_WEIGHT: number = 1;

  /**
   * 登陆界面url
   */
  static readonly LOGIN_PAGE_URL:string = "pages/LoginPage"
  /**
   * Registration success page scroll layout weight.
   */
  static readonly SCROLL_LAYOUT_WEIGHT: number = 1;

  /**
   * Mine page column layout weight.
   */
  static readonly COLUMN_LAYOUT_WEIGHT: number = 1;

  /**
   * Mine page list size.
   */
  static readonly LIST_SIZE: number = 2;

  /**
   * TopBar font weight.
   */
  static readonly TITLE_FONT_WEIGHT: number = 500;

  /**
   * Login text font weight.
   */
  static readonly LOGIN_TEXT_FONT_WEIGHT: number = 500;

  /**
   * Button font weight of registration page.
   */
  static readonly BUTTON_FONT_WEIGHT: number = 500;

  /**
   * Text font weight of registration page.
   */
  static readonly TEXT_FONT_WEIGHT: number = 500;

  /**
   * User nickname text font weight.
   */
  static readonly NICKNAME_FONT_WEIGHT: number = 500;

  /**
   * Registration success page url.
   */
  static readonly REGISTRATION_SUCCESS_PAGE_URL: string = 'pages/RegistrationSuccessPage';

  /**
   * Privacy page url.
   */
  static readonly PRIVACY_PAGE_URL: string = 'pages/PrivacyPage';

  /**
   * Customer service page url.
   */
  static readonly CUSTOMER_SERVICE_PAGE_URL: string = 'pages/CustomerServicePage';

  /**
   * Percent of the text input.
   */
  static readonly TEXT_INPUT_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of divider width.
   */
  static readonly DIVIDER_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the button width.
   */
  static readonly BUTTON_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the flex width.
   */
  static readonly FLEX_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the login page width.
   */
  static readonly LOGIN_PAGE_WIDTH_PERCENT: string = '100%';

  /**
   * Full percent of the width.
   */
  static readonly FULL_WIDTH_PERCENT: string = '100%';

  // 90% 宽
  static readonly NINETY_WIDTH_PERCENT: string = '90%';

  // 80% 宽
  static readonly EIGHTY_WIDTH_PERCENT: string = '80%';

  /**
   * Percent of the registration success page width.
   */
  static readonly REGISTRATION_PAGE_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the registration success page height.
   */
  static readonly REGISTRATION_PAGE_HEIGHT_PERCENT: string = '100%';

  /**
   * Percent of text width in mine page.
   */
  static readonly MINE_PAGE_TEXT_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of the mine page width.
   */
  static readonly MINE_PAGE_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of column width in customer service page.
   */
  static readonly CUSTOMER_COLUMN_WIDTH_PERCENT: string = '100%';

  /**
   * Percent of column height in customer service page.
   */
  static readonly CUSTOMER_COLUMN_HEIGHT_PERCENT: string = '100%';

  /**
   * Percent of column height in mine page.
   */
  static readonly MINE_PAGE_HEIGHT_PERCENT: string = '100%';

  /**
   * Percent of the row width.
   */
  static readonly ROW_WIDTH_PERCENT: string = '100%';

  /**
   * Scroll height percentage setting.
   */
  static readonly SCROLL_HEIGHT_PERCENT: string = '100%';

  /**
   * Percent of the column width in detail page.
   */
  static readonly DETAIL_COLUMN_WIDTH_PERCENT: string = '93%';

  /**
   * 注册界面路由
   */
  static readonly REGISTER_PAGE_URL: string = 'pages/RegisterPage';

  /**
   * 主界面路由
   */
  static readonly MAIN_PAGE_URL: string = 'pages/MainPage';

  /**
   * 大语言界面路由
   */
  static readonly LLM_PAGE_URL: string = 'pages/LLMPage';

  /**
   * 联系人界面路由
   */
  static readonly CONTACTS_PAGE_URL: string = 'pages/ContactsPage';

  /**
   * 动态界面路由
   */
  static readonly MOMENTS_PAGE_URL: string = 'pages/momentPages/MomentsPage';

  /**
   * 设置界面路由
   */
  static readonly SETTINGS_PAGE_URL: string = 'pages/settingPages/SettingsPage';
  /**
   * 设置聊天列表路由
   */
  static readonly CHAT_LIST_PAGE_URL: string = 'pages/chatPages/ChatListPage';
  /**
   * 设置聊天细节路由
   */
  static readonly CHAT_DETAIL_PAGE_URL: string = 'pages/chatPages/ChatDetailPage'

  /**
   * 设置好友页面路由
   */
  static readonly ADD_FRIEND_PAGE_URL: string = 'pages/contactPages/AddFriendsPage';

  /**
   * 设置整张图片界面路由
   */
  static readonly FULL_IMAGE_PAGE_URL: string = 'pages/momentPages/FullImagePage'

  /**
   * 设置发现界面路由
   */
  static readonly DISCOVER_PAGE_URL: string = 'pages/DiscoverPage'

  /**
   * 设置头像界面
   */
  static readonly SETTING_PROFILE_PICTURE_PAGE_URL: string = 'pages/settingPages/SettingProfilePicturePage'

  /**
   * 设置用户名界面
   */
  static readonly SETTING_USERNAME_PAGE_URL: string = 'pages/settingPages/SettingUsernamePage'

  /**
   * 设置签名界面
   */
  static readonly SETTING_SIGNATURE_PAGE_URL: string = 'pages/settingPages/SettingSignaturePage'

  /**
   * 设置性别界面
   */
  static readonly SETTING_GENDER_PAGE_URL: string = 'pages/settingPages/SettingGenderPage'

  /**
   * 设置聊天细节界面
   */
  static readonly DETAIL_PAGE_URL: string = 'pages/chatPages/Detail'

  /**
   * 设置好友申请处理界面
   */
  static readonly NEW_FRIENDS_PAGE_URL: string = 'pages/contactPages/NewFriendsPage'

  /**
   * 设置好友详情界面
   */
  static readonly FRIEND_DETAIL_PAGE_URL: string = 'pages/contactPages/FriendDetailPage'

  /**
   * 设置添加动态界面
   */
  static readonly ADD_MOMENTS_PAGE_URL: string = 'pages/momentPages/AddMomentsPage'
}