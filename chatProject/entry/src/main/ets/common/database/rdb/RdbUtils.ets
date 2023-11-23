/**
 * RdbUtils类的实现 用于操作关系型数据库
 *
 * 提供了创建数据库 创建表 插入数据 更新数据 查询数据功能
 */

import dataRdb from '@ohos.data.relationalStore';
import ColumnInfo from '../../../viewmodel/ColumnInfo';
import { RdbHelper } from './RdbHelper';
import { RdbHelperImp } from './RdbHelperImp';
// import Logger from '../../utils/Logger';//引入日志生成器
import Queue from '@ohos.util.Queue';

let dbContext: Context;
let mDatabaseName: string = '';

export class RdbUtils {
  private rdbHelpers = new Map<string, RdbHelper>();

  initDb(context: Context, databaseName: string) {
    dbContext = context;
    mDatabaseName = databaseName;
  }

  createDb(): Promise<RdbHelper> {
    return new Promise<RdbHelper>((success, error) => {
      let dbName = mDatabaseName;
      if (!dbContext || !dbName || dbName.length === 0) {
        error("init err");
        return;
      }
      let dbHelper = this.rdbHelpers.get(dbName);
      if (!dbHelper) {
        // Logger.info(`initRdb  RdbUtils success`);//生成日志
        let rdbHelper: RdbHelper = new RdbHelperImp(dbName);
        rdbHelper.getRdb(dbContext).then(data => {
          this.rdbHelpers.set(dbName, data);
          success(data);
        }).catch((err: Error) => {
          error(err);
        })
      } else {
        success(dbHelper);
      }
    })
  }

  deleteDb(context: Context, dbName: string): Promise<void> {
    this.rdbHelpers.delete(dbName);
    return dataRdb.deleteRdbStore(context, dbName);
  }

  createTable(tableName: string, columns: Array<ColumnInfo>): Promise<void> {
    return this.createDb().then(dbHelper => {
      return dbHelper.createTable(tableName, columns);
    });
  }

  isCreateTable(tableName: string, columns: Array<ColumnInfo>): Promise<boolean> {
    return this.createTable(tableName, columns).then(() => {
      return true;
    }).catch((error: Error) => {
      // Logger.error('RdbUtils', 'create table error ' + JSON.stringify(error));//生成日志
      return false;
    });
  }

  deleteTable(tableName: string): Promise<void> {
    return this.createDb().then(dbHelper => {
      return dbHelper.deleteTable(tableName);
    })
  }

  executeSql(sql: string): Promise<void> {
    return this.createDb().then(dbHelper => {
      return dbHelper.executeSql(sql);
    })
  }

  addTableColumn(tableName: string, column: ColumnInfo): Promise<void> {
    return this.createDb().then(dbHelper => {
      return dbHelper.addTableColumn(tableName, column);
    })
  }

  insert(tableName: string, values: dataRdb.ValuesBucket | Array<dataRdb.ValuesBucket>): Promise<number> {
    return this.createDb().then(dbHelper => {
      return dbHelper.insert(tableName, values);
    })
  }

  update(values: dataRdb.ValuesBucket, rdbPredicates: dataRdb.RdbPredicates): Promise<number> {
    return this.createDb().then(dbHelper => {
      return dbHelper.update(values, rdbPredicates);
    })
  }

  query(rdbPredicates: dataRdb.RdbPredicates, columns?: Array<string>): Promise<dataRdb.ResultSet> {
    return this.createDb().then(dbHelper => {
      return dbHelper.query(rdbPredicates, columns);
    })
  }

  queryAll(tableName: string): Promise<dataRdb.ResultSet> {
    return this.createDb().then(dbHelper => {
      return dbHelper.queryAll(tableName);
    })
  }

  queryBySql(sql: string, bindArgs?: Array<dataRdb.ValueType>): Promise<dataRdb.ResultSet> {
    return this.createDb().then(dbHelper => {
      return dbHelper.queryBySql(sql, bindArgs);
    })
  }

  del(rdbPredicates: dataRdb.RdbPredicates): Promise<number> {
    return this.createDb().then(dbHelper => {
      return dbHelper.delete(rdbPredicates);
    })
  }
}

let rdbUtils = new RdbUtils();

export default rdbUtils as RdbUtils;