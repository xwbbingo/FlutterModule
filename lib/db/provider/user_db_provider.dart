import 'package:sqflite/sqflite.dart';
import 'package:start_app/db/model/user_model.dart';
import 'package:start_app/db/sql_provider.dart';

class UserDbProvider extends BaseDbProvider {
  final String dbName = 'User';

  final String columnId = 'id';
  final String columnUserName = 'userName';
  final String columnUserAge = 'userAge';
  final String columnUserSex = 'userSex';
  final String columnUserMobile = 'userMobile';

  UserDbProvider();

  //----------------------写法2用到---------------------//
  int id;
  String userName;
  String userAge;
  String userSex;

  Map<String, dynamic> toMap(String userName, String userAge,
      {String userSex}) {
    Map<String, dynamic> map = {
      columnUserName: userName,
      columnUserAge: userAge,
      columnUserSex: userSex
    };
    if (userSex != null) {
      map[columnUserSex] = userSex;
    }
    if (userSex != null) {
      map[columnUserSex] = userSex;
    }
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  UserDbProvider.fromMap(Map map) {
    id = map[columnId];
    userName = map[columnUserName];
    userAge = map[columnUserAge];
    userSex = map[columnUserSex];
  }
  //--------------------------------------------------//

  @override
  tableName() {
    return dbName;
  }

  @override
  tableSqlString() {
    //注意点：数据库更新时将新增字段（修改字段）添加。 防止用户删除app,重新安装app,数据库找不到相应字段

    //1
    // return tableBaseString(dbName, columnId) +
    //     '''
    // $columnUserName text not null,
    // $columnUserAge text not null)
    // ''';

    //2
    return tableBaseString(dbName, columnId) +
        '''
    $columnUserName text not null,
    $columnUserAge text not null,
    $columnUserSex text not null)
    ''';

    //3
    // return tableBaseString(dbName, columnId) +
    //     '''
    // $columnUserName text not null,
    // $columnUserAge text not null,
    // $columnUserSex text not null,
    // $columnUserMobile text not null)
    // ''';
  }

  @override
  tableUpdateString(int updateVersion) {
    //考虑点: 根据版本号来区别更新语句 （中间有过多次更新）
    // --修改字段
    // -- ALTER TABLE product CHANGE address address1 VARCHAR(20);
    //添加标志位,用于判断增加表字段或修改表字段
    if (updateVersion == 2) {
      return 'alter table $dbName add $columnUserSex text'; //不能加not null,否则会报异常, 添加需加默认值
    } else if (updateVersion == 3) {
      return 'alter table $dbName add $columnUserMobile text';
    }
  }

  //--------------------------写法1-------------------------------//
  //查询
  Future<List<UserModel>> getTotalList() async {
    var dbClient = await getDataBase();
    var result = await dbClient.rawQuery("SELECT * FROM $dbName ");
    // return result.toList();
    return List.generate(result.length, (index) {
      return UserModel.fromJson(result[index]);
    });
  }

  //查询总数
  Future<int> getCount() async {
    var dbClient = await getDataBase();
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $dbName"));
  }

  ///查询数据库
  Future _getRawProvider(Database db, int id) async {
    List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from $dbName where $columnId = $id");
    return maps;
  }

  ///插入到数据库
  Future insertUser(UserModel model) async {
    Database db = await getDataBase();
    var userProvider = await _getRawProvider(db, model.id);
    if (userProvider != null) {
      ///删除数据
      await db.delete(dbName, where: "$columnId = ?", whereArgs: [model.id]);
    }
    //更新前 1
    // return await db.insert(dbName, toMap(model.userName, model.userAge));
    // return await db.rawInsert(
    //     "insert into $dbName ($columnId,$columnUserName,$columnUserAge) values (?,?,?)",
    //     [
    //       model.id,
    //       model.userName,
    //       model.userAge,
    //     ]);

    //更新前 2
    // return await db.insert(
    //     dbName, toMap(model.userName, model.userAge, model.userSex));
    return await db.rawInsert(
        "insert into $dbName ($columnId,$columnUserName,$columnUserAge,$columnUserSex) values (?,?,?,?)",
        [
          model.id,
          model.userName,
          model.userAge,
          model.userSex,
        ]);

    //更新后 3
    // return await db.rawInsert(
    //     "insert into $dbName ($columnId,$columnUserName,$columnUserAge,$columnUserSex,$columnUserMobile) values (?,?,?,?,?)",
    //     [
    //       model.id,
    //       model.userName,
    //       model.userAge,
    //       model.userSex,
    //       model.userMobile,
    //     ]);
  }

  ///插入到数据库
  Future deleteUser(UserModel model) async {
    Database db = await getDataBase();
    var userProvider = await _getRawProvider(db, model.id);
    if (userProvider != null) {
      ///删除数据
      await db.delete(dbName, where: "$columnId = ?", whereArgs: [model.id]);
    }
  }

  ///更新数据库
  Future<void> updateUser(UserModel model) async {
    Database database = await getDataBase();
    //1
    // await database.rawUpdate(
    //     "update $dbName set $columnUserName = ?,$columnUserAge = ? where $columnId= ?",
    //     [
    //       model.userName,
    //       model.userAge,
    //       model.id,
    //     ]);
    //2
    await database.rawUpdate(
        "update $dbName set $columnUserName = ?,$columnUserAge = ?,$columnUserSex = ? where $columnId= ?",
        [
          model.userName,
          model.userAge,
          model.userSex,
          model.id,
        ]);
    //3
    // await database.rawUpdate(
    //     "update $dbName set $columnUserName = ?,$columnUserAge = ?,$columnUserSex = ?,$columnUserMobile = ? where $columnId= ?",
    //     [
    //       model.userName,
    //       model.userAge,
    //       model.userSex,
    //       model.userMobile,
    //       model.id
    //     ]);
  }

  ///获取事件数据
  Future<UserModel> getUserInfo(int id) async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await _getRawProvider(db, id);
    if (maps.length > 0) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }

  ///清空数据
  Future<int> clear() async {
    var db = await getDataBase();
    return await db.delete(dbName);
  }

  //--------------------------写法2-------------------------------//
  Future _getProvider(Database db, String userName) async {
    List<Map<String, dynamic>> maps = await db.query(dbName,
        columns: [columnId, columnUserName, columnUserAge, columnUserSex],
        where: "$columnUserName = ?",
        whereArgs: [userName]);
    if (maps.length > 0) {
      UserDbProvider provider = UserDbProvider.fromMap(maps.first);
      return provider;
    }
    return null;
  }

  ///插入数据
  Future insert(String userName, String userAge, String userSex) async {
    Database db = await getDataBase();
    //获取查到的记录
    var provider = await _getProvider(db, userName);
    if (provider != null) {
      //删除记录
      await db
          .delete(dbName, where: "$columnUserName = ?", whereArgs: [userName]);
    }
    //插入记录
    return await db.insert(dbName, toMap(userName, userAge, userSex: userSex));
  }

  ///删除数据
  Future delete(String userName) async {
    Database db = await getDataBase();
    //获取查到的记录
    var provider = await _getProvider(db, userName);
    if (provider != null) {
      //删除记录
      return await db
          .delete(dbName, where: "$columnUserName = ?", whereArgs: [userName]);
    }
  }

  ///修改数据
  Future update(String userName, {String userAge, String userSex}) async {
    Database db = await getDataBase();
    //获取查到的记录
    var provider = await _getProvider(db, userName);
    if (provider != null) {
      //修改记录
      return await db.update(dbName, toMap(userName, userAge, userSex: userSex),
          where: "$columnUserName = ?", whereArgs: [userName]);
    }
  }

  ///查询数据
  Future<List<UserModel>> query(String userName) async {
    Database db = await getDataBase();
    //获取查到的记录
    List<Map<String, dynamic>> maps = await db
        .query(dbName, where: "$columnUserName = ?", whereArgs: [userName]);

    return List.generate(maps.length, (index) {
      return UserModel.fromJson(maps[index]);
    });
  }
}
