/// id : 1
/// userName : "张三"
/// userAge : "25"
/// userSex : "男"

class UserModel {
  UserModel({
    this.id,
    this.userName,
    this.userAge,
    this.userSex,
    this.userMobile,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    userName = json['userName'];
    userAge = json['userAge'];
    userSex = json['userSex'];
    userMobile = json['userMobile'];
  }

  int id;
  String userName;
  String userAge;
  String userSex;
  String userMobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userName'] = userName;
    map['userAge'] = userAge;
    map['userSex'] = userSex;
    map['userMobile'] = userMobile;
    return map;
  }
}
