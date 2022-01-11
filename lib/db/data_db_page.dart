import 'dart:math';

import 'package:flutter/material.dart';
import 'package:start_app/db/model/user_model.dart';
import 'package:start_app/db/provider/user_db_provider.dart';
import 'package:start_app/utils/gg_log_util.dart';

class DataDbPage extends StatefulWidget {
  const DataDbPage({Key key}) : super(key: key);

  @override
  _DataDbPageState createState() => _DataDbPageState();
}

class _DataDbPageState extends State<DataDbPage> {
  List<UserModel> _datas = [];
  UserDbProvider dbProvider = UserDbProvider();
  @override
  void initState() {
    super.initState();
    _getDataFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite demo'),
        centerTitle: true,
        actions: [
          PopupMenuButton(onSelected: (String value) {
            switch (value) {
              case "add":
                _add();
                break;
              case "delete":
                _delete();
                break;
              case "update":
                _update();
                break;
              case "query":
                _query();
                break;
              case "clear":
                _clear();
                break;
            }
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: "add", child: Text("增加")),
              PopupMenuItem(value: "delete", child: new Text("删除")),
              PopupMenuItem(value: "update", child: new Text("修改")),
              PopupMenuItem(value: "query", child: new Text("查询")),
              PopupMenuItem(value: "clear", child: new Text("清空")),
            ];
          })
        ],
      ),
      body: RefreshIndicator(
        displacement: 15,
        onRefresh: () async {
          if (_datas != null && _datas.length > 0) {
            _query();
          } else {
            _getDataFromDb();
          }
        },
        child: ListView.separated(
            itemBuilder: _renderRow,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 0.5,
                color: Colors.black12,
              );
            },
            itemCount: _datas.length),
      ),
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: Text("id：" + _datas[index].id.toString())),
        Padding(
            padding: EdgeInsets.all(5),
            child: Text("姓名：" + _datas[index].userName)),
        Padding(
            padding: EdgeInsets.all(5),
            child: Text("年龄：" + _datas[index].userAge)),
        Padding(
            padding: EdgeInsets.all(5),
            child: Text("性别：" + _datas[index].userSex)),
        _datas[index].userMobile != null
            ? Padding(
                padding: EdgeInsets.all(5),
                child: Text("手机：" + _datas[index].userMobile))
            : Container(),
      ],
    );
  }

  void _getDataFromDb() async {
    _datas = await dbProvider.getTotalList();
    if (_datas == null || _datas.length == 0) {
      UserModel user1 = UserModel();
      user1.userName = "张三";
      user1.userAge = "30";
      user1.userSex = "男";
      user1.userMobile = "13${Random().nextInt(20)}";

      UserModel user2 = UserModel();
      user2.userName = "李四";
      user2.userAge = "32";
      user2.userSex = "女";
      user2.userMobile = "13${Random().nextInt(20)}";

      await dbProvider.insertUser(user1);
      await dbProvider.insertUser(user2);
    }
    _query();
  }

  //添加
  Future<Null> _add() async {
    UserModel user = new UserModel();
    user.userName = "我是增加的${Random().nextInt(99)}";
    user.userAge = Random().nextInt(99).toString();
    user.userSex = Random().nextInt(2) == 0 ? "男" : "女";
    user.userMobile = "13${Random().nextInt(20)}";
    await dbProvider.insertUser(user);
    _query();
  }

  //删除,默认删除第一条数据
  Future<Null> _delete() async {
    List<UserModel> datas = await dbProvider.getTotalList();
    if (datas.length > 0) {
      //修改第一条数据
      GgLogUtil.v("${datas.first.id}");
      UserModel user = datas.first;
      await dbProvider.deleteUser(user);
      _query();
    }
  }

  //修改，默认修改第一条数据
  Future<Null> _update() async {
    List datas = await dbProvider.getTotalList();
    if (datas.length > 0) {
      //修改第一条数据
      GgLogUtil.v("${Random().nextInt(2)}");
      UserModel u = datas.first;
      u.userName = "我被修改了${Random().nextInt(99)}";
      u.userAge = Random().nextInt(70).toString();
      u.userSex = Random().nextInt(2) == 0 ? "男" : "女";
      await dbProvider.updateUser(u);
      _query();
    }
  }

  //查询
  Future<Null> _query() async {
    _datas.clear();
    List<UserModel> datas = await dbProvider.getTotalList();
    _datas.addAll(datas);
    setState(() {});
  }

  Future<Null> _clear() async {
    await dbProvider.clear();
    _query();
  }
}
