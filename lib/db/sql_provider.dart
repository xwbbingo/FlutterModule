import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:start_app/db/sql_manager.dart';
import 'package:start_app/utils/gg_log_util.dart';

/// 基类
abstract class BaseDbProvider {
  bool isTableExits = false;

  tableSqlString();

  tableUpdateString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''
    create table $name (
    $columnId integer primary key autoincrement,
    ''';
  }

  //新增更新字段时的方法

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString(), tableUpdateString());
    }
    return await SqlManager.getCurrentDatabase();
  }

  @mustCallSuper
  prepare(name, createSql, updateSql) async {
    isTableExits = await SqlManager.isTableExits(name);
    GgLogUtil.v("表是否已存在=> $isTableExits");
    if (!isTableExits) {
      GgLogUtil.v("新建Sql=> $createSql");
      //新建表
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    } else if (SqlManager.isTableUpdate()) {
      //更新表
      Database db = await SqlManager.getCurrentDatabase();
      GgLogUtil.v("更新Sql=> $updateSql");
      //问题:表存在,需要删除老表,将老表的数据转移至新表
      Batch batch = db.batch();

      //根据版本号获取不同的sql, 进行更新操作

      //新增字段的sql
      // batch.execute('alter table ta_person add fire text');
      batch.execute(updateSql);
      //更改字段的sql

      return await batch.commit();
    }
  }
}
