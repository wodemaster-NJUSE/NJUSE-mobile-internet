/**
 * 引入列的定义
 * 定义列
 * name: string：表示列的名称。
 * type: string：表示列的数据类型。
 * length?: number：表示列的长度，这是一个可选的属性，可能不会对所有类型的列都适用。
 * nullable?: boolean：表示列是否可为空，也是一个可选的属性。
 * primary?: boolean：表示列是否为主键，同样是一个可选的属性。
 * autoincrement?: boolean：表示列是否具有自动增量，同样是一个可选的属性。
 */

/**
 * Column Info.
 *
 */
export default class ColumnInfo {
  name: string;
  type: string;
  length?: number;
  nullable?: boolean;
  primary?: boolean;
  autoincrement?: boolean;

  constructor(name: string, type: string, length?: number, nullable?: boolean,
              primary?: boolean, autoincrement?: boolean) {
    this.name = name;
    this.type = type;
    this.primary = primary;
    this.length = length;
    this.nullable = nullable;
    this.autoincrement = autoincrement;
  }
}


