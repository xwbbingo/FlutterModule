import 'package:flutter/material.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_list_bloc.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/base_stateless_widget.dart';
import 'package:start_app/demo/flutter_architecture/commonui/bloc/loading_bean.dart';

import 'bloc_provider.dart';

abstract class BaseListStatelessWidget<T, B extends BaseListBloc<T>>
    extends BaseStatelessWidget<LoadingBean<List<T>>, B> {
  static final String TAG = "BaseListStatelessWidget";

  Widget builderItem(BuildContext context, T item);

  bool enablePullUp(BuildContext context) {
    BaseListBloc bloc = BlocProvider.of<B>(context);

    return !bloc.noMore;
  }

  @override
  bool isLoading(LoadingBean<List<T>> data) {
    return data != null ? data.isLoading : true;
  }

  @override
  int getItemCount(LoadingBean<List<T>> data) {
    if (data == null) {
      return 0;
    }
    return data.data == null ? 0 : data.data.length;
  }

  @override
  Widget buildItemBuilder(
      BuildContext context, LoadingBean<List<T>> data, int index) {
    T model = data.data[index];
    return builderItem(context, model);
  }
}
