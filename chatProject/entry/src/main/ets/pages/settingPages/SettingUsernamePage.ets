import { SettingDetailView } from '../../viewmodel/SettingDetailViewModel';

@Entry
@Component
struct SettingUsernamePage {
  build() {
    Column() {
      SettingDetailView({
        title : '设置用户名',
        inputPlaceholder : "给自己起个好名字吧...",
        maxInputLength : 20
      })
    }
  }
}