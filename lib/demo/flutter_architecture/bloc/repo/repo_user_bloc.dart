import 'package:start_app/demo/flutter_architecture/bloc/repo/repo_bloc.dart';
import 'package:start_app/demo/flutter_architecture/manager/repos_manager.dart';

class RepoUserBloc extends RepoBloc {
  RepoUserBloc(String userName) : super(userName);

  @override
  fetchRepos(int page) async {
    return await ReposManager.instance
        .getUserRepos(userName, page, null, false);
  }
}
