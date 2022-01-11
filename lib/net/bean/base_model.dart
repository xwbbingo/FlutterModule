class BaseModel {
  //响应数据
  var data;
  //响应结果
  bool result;
  //请求响应码
  int code;
  //请求提示
  String msg;

  BaseModel(this.data, this.result, this.code, {this.msg});
}
