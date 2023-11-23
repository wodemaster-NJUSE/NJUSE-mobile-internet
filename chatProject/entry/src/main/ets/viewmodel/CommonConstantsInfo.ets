/*
 * 定义了一个 CommonConstantsInfo 类，
 * 包含了 dbName、tableName 和 columns 字段
 * 分别表示数据库名称、表名称和列名的数组
 */

/**
 * Common constants info
 */
export default class CommonConstantsInfo {
  dbName?: string = '';
  tableName?: string = '';
  columns?: Array<string> = [];
}
