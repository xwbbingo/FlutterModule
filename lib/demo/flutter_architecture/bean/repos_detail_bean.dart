import 'package:start_app/demo/flutter_architecture/bean/branch_bean.dart';
import 'package:start_app/demo/flutter_architecture/bean/repos_bean.dart';
import 'package:start_app/demo/flutter_architecture/status/status.dart';

class ReposDetailBean {
  Repository repos;
  String readme;
  ReposStatus starStatus;
  ReposStatus watchStatus;
  List<BranchBean> branchs;

  ReposDetailBean(
      {this.repos,
      this.readme,
      this.starStatus,
      this.watchStatus,
      this.branchs});
}
