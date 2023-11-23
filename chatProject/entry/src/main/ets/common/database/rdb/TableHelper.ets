/**
 * 该文件中的 TableHelper 类包含了一些数据库表相关的方法
 *
 * createTableSql 用于生成创建数据库表的 SQL 语句 接受表名 tableName 和列信息数组 columns ，生成相应的 SQL 语句
 *
 * addTableColumnSql 用于生成向数据库表中添加列的 SQL 语句 接受表名 tableName 和列信息 column ,生成相应的 SQL 语句
 *
 * deleteTableSql 用于生成删除数据库表的 SQL 语句 接受表名 tableName, 并生成相应的 SQL 语句
 *
 *  该文件还导出了一个名为 tableHelper 的实例，通过 export default 语句进行导出
 *
 */

import ColumnInfo from '../../../viewmodel/ColumnInfo';
// import Logger from '../../utils/Logger';//日志生成

class TableHelper {
  createTableSql(tableName: string, columns: Array<ColumnInfo>): string {
    let sql = `create table if not exists ${tableName}(`;
    for (let column of columns) {
      sql = sql.concat(`${column.name} ${column.type}`);
      sql = sql.concat(`${column.length && column.length > 0 ? `(${column.length})` : ''}`);
      sql = sql.concat(`${column.primary ? ' primary key' : ''}`);
      sql = sql.concat(`${column.autoincrement ? ' autoincrement' : ''}`);
      sql = sql.concat(`${column.nullable ? '' : ' not null'}`);
      sql = sql.concat(', ');
    }
    sql = `${sql.substring(0, sql.length - 2)})`;
    return sql;
  }

  addTableColumnSql(tableName: string, column: ColumnInfo): string {
    // Logger.info(`TableHelper updateTableSql : ${JSON.stringify(column)}`);
    let sql = `alter table ${tableName} add `;
    sql = sql.concat(`${column.name} ${column.type}`);
    sql = sql.concat(`${column.length && column.length > 0 ? `(${column.length})` : ''}`);
    // Logger.info(`TableHelper updateTableSql : ` + sql);
    return sql;
  }

  deleteTableSql(tableName: string): string {
    // Logger.info(`TableHelper deleteTableSql : ${JSON.stringify(tableName)}`);
    return `drop table if exists ${tableName}`;
  }
}

const tableHelper = new TableHelper();

export default tableHelper;