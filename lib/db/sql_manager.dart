import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:start_app/utils/gg_log_util.dart';

/**
 * 数据库管理
 */
class SqlManager {
  static const _VERSION = 3;

  static const _DB_NAME = "start_app.db";

  static Database _database;

  static bool needUpdate = false;

  ///初始化
  static init() async {
    var databasePath = await getDatabasesPath();

    String dbName = _DB_NAME;
    // 可根据登录用户来做区分判断,建立对应的表
    if (databasePath != null) {
      String path = databasePath + dbName;
      if (Platform.isIOS) {
        path = databasePath + "/" + dbName;
      }
      _database = await openDatabase(path, version: _VERSION,
          onCreate: (Database db, int version) async {
        GgLogUtil.v("新建$version");
        // When creating the db, create the table
        //await db.execute("CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)");
      }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
        GgLogUtil.v("更新$oldVersion / $newVersion");
        needUpdate = oldVersion < newVersion;
      });
    }
  }

  /// 表是否存在
  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database?.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  /// 表是否更新
  static isTableUpdate() {
    return needUpdate;
  }

  ///获取当前数据库对象
  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  ///关闭
  static close() {
    _database?.close();
    _database = null;
  }
}
