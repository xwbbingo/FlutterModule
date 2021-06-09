import 'base_bloc.dart';
import 'loading_bean.dart';

abstract class BaseListBloc<T> extends BaseBloc<LoadingBean<List<T>>> {
  BaseListBloc() {
    bean = new LoadingBean(isLoading: false, data: []);
  }

  onRefresh() async {
    page = 1;
    await super.onRefresh();
  }

  onLoadMore() async {
    page++;
    await super.onLoadMore();
  }
}
