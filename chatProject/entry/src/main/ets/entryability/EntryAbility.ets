import type AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import type Want from '@ohos.app.ability.Want';
import type window from '@ohos.window';

/**
 * Lift cycle management of Ability.
 */

import { CommonConstants as Const } from '../common/constants/CommonConstants';
import RdbUtils from '../common/database/rdb/RdbUtils';
import {
 columnUsersInfoList
} from '../model/RdbColumnModel';
// import Logger from '../common/utils/Logger';

export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam){
    // GlobalContext.getContext().setObject('want', want);
    // GlobalContext.getContext().setObject('launchParam', launchParam);

    RdbUtils.initDb(this.context, Const.RDB_NAME.dbName ? Const.RDB_NAME.dbName : '');
    await RdbUtils.createDb();

    RdbUtils.createTable(Const.USERS_INFO.tableName ? Const.USERS_INFO.tableName : '', columnUsersInfoList).then(() => {
      // Logger.info(`RdbHelper createTable dayInfo success`);
    }).catch((err: Error) => {
      // Logger.error(`RdbHelper dayInfo err : ${JSON.stringify(err)}`);
    });
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent("pages/LoginPage", (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
