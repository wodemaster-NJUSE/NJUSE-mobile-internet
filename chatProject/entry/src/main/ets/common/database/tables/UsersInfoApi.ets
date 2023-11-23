/**
 * 用于进行数据库的插入、更新和查询操作
 */

import dataRdb from '@ohos.data.relationalStore';
import UsersInfo from '../../../viewmodel/UsersInfo';
import { CommonConstants as Const } from '../../constants/CommonConstants'
import RdbUtils from '../Rdb/RdbUtils';
// import Logger from '../../utils/Logger';

class UsersInfoApi {

/**
 *
 * @param usersInfo
 * @param callback
 *
 * 添加 UsersInfo
 */
  insertData(usersInfo: UsersInfo, callback: Function): void {
    const valueBucket = generateBucket(usersInfo);
    RdbUtils.insert('UsersInfo', valueBucket).then(result => {
      callback(result);
    })
    // Logger.info('UsersInfoTable', 'Insert UsersInfo finished.');
  }

  // /**
  //  * Update UsersInfo.
  //  *
  //  * @param UsersInfo
  //  * @param callback
  //  */
  // updateData(usersInfo: UsersInfo, callback: Function): void {
  //   const valueBucket = generateBucket(usersInfo);
  //   let predicates: dataRdb.RdbPredicates = new dataRdb.RdbPredicates(Const.USERS_INFO.tableName ? Const.USERS_INFO.tableName : '');
  //   predicates.equalTo('name', usersInfo.name);
  //   RdbUtils.update(valueBucket, predicates).then((result: number) => {
  //     callback(result);
  //   });
  //   // Logger.info('UsersInfoTable', 'Update UsersInfo finished.');
  // }

  /**
   * Query UsersInfo.
   *
   * @param name
   * @param callback
   *
   * 根据用户名查找 UsersInfo
   * 查找到 返回对应 UsersInfo
   * 未查找到 返回 新建的 name = "" password = "" 的 UsersInfo 空的
   */
  query(name: string, callback: Function): void {
    //query by name
    let predicates: dataRdb.RdbPredicates = new dataRdb.RdbPredicates(Const.USERS_INFO.tableName ? Const.USERS_INFO.tableName : '');
    predicates.equalTo('name', name);

    RdbUtils.query(predicates).then(resultSet => {
      let count = resultSet.rowCount;
      if (count === 0) {
        // Logger.info('UsersInfoTable', 'query no results.');
        let result = new UsersInfo('', '');
        callback(result);
      } else {
        let result = new UsersInfo('', '');

        //返回结果集第一个
        resultSet.goToFirstRow();
        result.name = resultSet.getString(resultSet.getColumnIndex('name'));
        result.password = resultSet.getString(resultSet.getColumnIndex('password'));
        callback(result);
      }
      return;
    });
  }

  /**
   * Query UsersInfo list.
   *
   * @param date
   * @param callback
   *
   * 查询一组 name
   * 查询到返回对应一组 UsersInfo
   */
  queryList(names: string[], callback: Function): void {

    let predicates: dataRdb.RdbPredicates = new dataRdb.RdbPredicates(Const.USERS_INFO.tableName ? Const.USERS_INFO.tableName : '');
    predicates.in('name', names);

    RdbUtils.query(predicates).then(resultSet => {
      let count = resultSet.rowCount;
      if (count === 0) {
        // Logger.info('UsersInfoTable', 'query no results.');
        let result: UsersInfo[] = [];
        callback(result);
      } else {
        resultSet.goToFirstRow();
        let result: UsersInfo[] = [];
        for (let i = 0; i < count; i++) {
          let tmp = new UsersInfo('', '');
          tmp.name = resultSet.getString(resultSet.getColumnIndex('name'));
          tmp.password = resultSet.getString(resultSet.getColumnIndex('password'));
          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }
}

function generateBucket(usersInfo: UsersInfo): dataRdb.ValuesBucket {
  let valueBucket = {} as dataRdb.ValuesBucket;
  Const.USERS_INFO.columns?.forEach((item: string) => {
    switch (item) {
      case 'name':
        valueBucket.date = usersInfo.name;
        break;
      case 'password':
        valueBucket.finTaskNum = usersInfo.password;
        break;
      default:
        break;
    }
  });
  return valueBucket;
}

let usersInfoApi = new UsersInfoApi();

export default usersInfoApi as UsersInfoApi;