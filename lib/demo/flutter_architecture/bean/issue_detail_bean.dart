import 'package:start_app/demo/flutter_architecture/bean/issue_bean.dart';

class IssueDetailBean {
  IssueBean issueBean;
  List<IssueBean> comments;

  IssueDetailBean({this.issueBean, this.comments});
}
