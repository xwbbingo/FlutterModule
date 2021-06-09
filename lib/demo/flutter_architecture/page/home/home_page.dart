import 'package:start_app/demo/flutter_architecture/bean/home_bean.dart';
import 'package:start_app/demo/flutter_architecture/bloc/home_bloc.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_stateless_widget.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/loading_bean.dart';

class HomePage extends BaseStatelessWidget<LoadingBean<HomeBean>, HomeBloc> {
  @override
  bool isLoading(LoadingBean<HomeBean> data) {}
}
