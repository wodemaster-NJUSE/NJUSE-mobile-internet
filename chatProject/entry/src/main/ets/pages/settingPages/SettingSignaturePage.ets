import { SettingDetailView } from '../../view/SettingDetailView';

@Entry
@Component
struct username {
  build() {
    Column() {
      SettingDetailView({
        title : '设置签名',
        inputPlaceholder : "写下签名，展现我的个性。",
        maxInputLength : 50
      })
    }
  }
}