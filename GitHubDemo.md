# GitHub Demo
#实现的功能如下：

1.实现Github账号登录、退出登录功能
2.登录后可以查看自己的项目主页
3.支持换肤
4.支持多语言
5.登录状态可以持久化；

要实现上面这些功能会涉及到如下技术点：

1.网络请求；需要请求Github API。
2.Json转Dart Model类；
3.全局状态管理；语言、主题、登录态等都需要全局共享。
4.持久化存储；保存登录信息，用户信息等。
5.支持国际化、Intl包的使用

#包结构
common	一些工具类，如通用方法类、网络接口类、保存全局变量的静态类等
l10n	国际化相关的类都在此目录下
models	Json文件对应的Dart Model类会在此目录下
states	保存APP中需要跨组件共享的状态类
routes	存放所有路由页面类
widgets	APP内封装的一些Widget组件都在该目录下


#json_model使用
1.在工程根目录下创建一个名为 "jsons" 的目录;
2.创建或拷贝Json文件到"jsons" 目录中 ;
3.运行 pub run json_model (Dart VM工程)or 
flutter packages pub run json_model(Flutter中) 命令生成Dart model类，生成的文件默认在"lib/models"目录下

flutter packages pub run build_runner build --delete-conflicting-outputs  //删除并重新创建.g.dart文件
flutter packages pub run build_runner build //使用 build_runner 生成 .g.dart 文件
flutter packages pub run build_runner wacth //监控生成文件，如果有改动时自动生成/更新 .g.dart 文件
