import { SettingDetailView } from '../../viewmodel/SettingDetailViewModel';

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