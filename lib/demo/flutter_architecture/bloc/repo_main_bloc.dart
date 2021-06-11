import 'package:start_app/demo/flutter_architecture/bloc/repo_bloc.dart';
import 'package:start_app/demo/flutter_architecture/manager/repos_manager.dart';

class RepoMainBloc extends RepoBloc {
  RepoMainBloc(String userName) : super(userName);

  @override
  fetchRepos(int page) async {
    return await ReposManager.instance.getRepos(page, null);
  }
}
