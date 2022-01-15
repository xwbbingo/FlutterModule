import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:start_app/db/sql_manager.dart';
import 'package:start_app/utils/gg_log_util.dart';

/// 基类
abstract class BaseDbProvider {
  bool isTableExits = false;

  tableSqlString();

  tableUpdateString(int updateVersion);

  tableName();

  tableBaseString(String name, String columnId) {
    return '''
    create table $name (
    $columnId integer primary key autoincrement,
    ''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await SqlManager.getCurrentDatabase();
  }

  @mustCallSuper
  prepare(name, createSql) async {
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
      while (SqlManager.nowOldVersion < SqlManager.nowNewVersion) {
        SqlManager.nowOldVersion++;
        //获取下一版本的更新sql ,根据版本号获取不同的sql, 进行更新操作
        String updateSql = tableUpdateString(SqlManager.nowOldVersion);
        GgLogUtil.v("更新Sql=> $updateSql  / ${SqlManager.nowOldVersion}");
        Batch batch = db.batch();
        //新增字段的sql
        // batch.execute('alter table ta_person add fire text');
        batch.execute(updateSql);
        await batch.commit();
      }
    }
  }
}
