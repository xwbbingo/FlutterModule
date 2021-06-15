///// id : 1234567
///// url : "https://api.github.com/authorizations/1234567"
///// app : {"name":"My app","url":"https://developer.github.com/v3/oauth_authorizations/","client_id":"00000000000000000000"}
///// token : "abcdef87654321"
///// hashed_token : "11"
///// token_last_eight : "22"
///// note : "33"
///// created_at : "44"
///// updated_at : "55"
///// scopes : ["66","77"]
//
//class LoginBean {
//  int id;
//  String url;
//  App app;
//  String token;
//  String hashedToken;
//  String tokenLastEight;
//  String note;
//  String createdAt;
//  String updatedAt;
//  List<String> scopes;
//
//  LoginBean(
//      {this.id,
//      this.url,
//      this.app,
//      this.token,
//      this.hashedToken,
//      this.tokenLastEight,
//      this.note,
//      this.createdAt,
//      this.updatedAt,
//      this.scopes});
//
//  LoginBean.fromJson(dynamic json) {
//    id = json["id"];
//    url = json["url"];
//    app = json["app"] != null ? App.fromJson(json["app"]) : null;
//    token = json["token"];
//    hashedToken = json["hashed_token"];
//    tokenLastEight = json["token_last_eight"];
//    note = json["note"];
//    createdAt = json["created_at"];
//    updatedAt = json["updated_at"];
//    scopes = json["scopes"] != null ? json["scopes"].cast<String>() : [];
//  }
//
//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["id"] = id;
//    map["url"] = url;
//    if (app != null) {
//      map["app"] = app.toJson();
//    }
//    map["token"] = token;
//    map["hashed_token"] = hashedToken;
//    map["token_last_eight"] = tokenLastEight;
//    map["note"] = note;
//    map["created_at"] = createdAt;
//    map["updated_at"] = updatedAt;
//    map["scopes"] = scopes;
//    return map;
//  }
//}
//
///// name : "My app"
///// url : "https://developer.github.com/v3/oauth_authorizations/"
///// client_id : "00000000000000000000"
//
//class App {
//  String name;
//  String url;
//  String clientId;
//
//  App({this.name, this.url, this.clientId});
//
//  App.fromJson(dynamic json) {
//    name = json["name"];
//    url = json["url"];
//    clientId = json["client_id"];
//  }
//
//  Map<String, dynamic> toJson() {
//    var map = <String, dynamic>{};
//    map["name"] = name;
//    map["url"] = url;
//    map["client_id"] = clientId;
//    return map;
//  }
//}
