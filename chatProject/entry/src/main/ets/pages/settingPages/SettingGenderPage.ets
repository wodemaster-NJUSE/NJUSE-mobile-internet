import { SettingDetailView } from '../../view/SettingDetailView';

@Entry
@Component
struct username {
  build() {
    Column() {
      SettingDetailView({
        title : '设置性别',
        inputPlaceholder : "这世上有那么多性别，你是哪一种？",
        maxInputLength : 20
      })
    }
  }
}