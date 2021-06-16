import 'package:start_app/demo/flutter_architecture/bloc/repo/repo_bloc.dart';
import 'package:start_app/demo/flutter_architecture/manager/repos_manager.dart';

class RepoUserStarBloc extends RepoBloc {
  RepoUserStarBloc(String userName) : super(userName);

  @override
  fetchRepos(int page) async {
    return await ReposManager.instance.getUserRepos(userName, page, null, true);
  }
}
