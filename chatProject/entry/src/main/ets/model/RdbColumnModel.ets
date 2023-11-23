/**
 * 定义了 columnUsersInfoList 数组
 * 每个数组包含了一系列的 ColumnInfo 对象，用于描述数据库表中的列信息。
 */

import ColumnInfo from '../viewmodel/ColumnInfo';

/**
 * 定义用户数组 包含两列
 * 第一列为 用户名
 * 第二列为 密码
 */

export const columnUsersInfoList: Array<ColumnInfo> = [
  new ColumnInfo('name', 'text', -1, true, true, false),//用户名称 文本 列长度 可空 为主键 自动增量否
  new ColumnInfo('password', 'text', -1, false, false, false),
];

