
import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import Logger from '../utils/Logger';
import Want from '@ohos.app.ability.Want';

const TAG: string = 'EntryAbility';
let currentWindowStage = null;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want): void {
    Logger.info(TAG, 'MainAbility onCreate' + JSON.stringify(want));
    AppStorage.SetOrCreate<Want>('want', want);
    PersistentStorage.PersistProp('lazy_for_each', true); // 懒加载初始化
    PersistentStorage.PersistProp('reusable', true); // 复用初始化
    PersistentStorage.PersistProp('image_sync_load', true); // 图片同步加载初始化
    PersistentStorage.PersistProp('page_layout', true); // 页面布局初始化
    PersistentStorage.PersistProp('list_cached_count', true); // 列表缓存条数初始化
    AppStorage.SetOrCreate('downComplete', false); // 初始化下载完成
    AppStorage.SetOrCreate('downLoadStatus', 0); // 初始化下载状态
    AppStorage.SetOrCreate('videoDuration', 0); // 初始化播放总时长
    AppStorage.SetOrCreate('videoCurrentTime', 0); // 初始化播放当前时长
  }

  onDestroy(): void {
    Logger.info(TAG, 'MainAbility onDestroy');
  }

  onNewWant(want: Want): void {
    if (want.parameters.kindId === undefined) {
      return;
    }
    Logger.info(TAG, "onNewWant want:" + JSON.stringify(want));
    AppStorage.SetOrCreate('want', want);
    if (currentWindowStage != null) {
      this.onWindowStageCreate(currentWindowStage);
    }
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    Logger.info(TAG, 'MainAbility onWindowStageCreate');

    //
    globalThis.context = this.context;

    if (currentWindowStage === null) {
      currentWindowStage = windowStage;
    }
    windowStage.loadContent('pages/LoginPage', (err, data) => {//从登陆界面开始
      if (err.code) {
        Logger.error(TAG, `Failed to load the content. Cause: ${JSON.stringify(err)}`);
        return;
      }
      Logger.info(TAG, `Succeeded in loading the content. Data:  ${JSON.stringify(data)}`);
    });

    windowStage.getMainWindow((err, data) => {
      if (err.code) {
        Logger.error(TAG, `Failed to obtain the main window.Cause: ${JSON.stringify(err)}`)
        return;
      }
      let windowClass = null;
      windowClass = data;
      // 设置监听键盘变化，用来设置inputView避让输入法
      try {
        windowClass.on('keyboardHeightChange', (data) => {
          Logger.info(TAG, `keyboardHeightChange.Data: ${JSON.stringify(data)}`)
          AppStorage.SetOrCreate('keyboardHeight', data)
        })
      } catch (exception) {
        Logger.error(TAG, `Failed to enable the listener for keyboard height changes.Cause: ${JSON.stringify(exception)}`)
      }
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    Logger.info(TAG, `MainAbility onWindowStageDestroy`);
  }

  onForeground(): void {
    // Ability has brought to foreground
    Logger.info(TAG, `MainAbility onForeground`);
  }

  onBackground(): void {
    // Ability has back to background
    Logger.info(TAG, `MainAbility onBackground`);
  }
}