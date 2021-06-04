import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:start_app/demo/flutter_weather/models/weather.dart';
import 'package:start_app/demo/flutter_weather/repositories/weather_repository.dart';

///发送事件，接口请求需要的参数
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherRequested extends WeatherEvent {
  final String city;

  const WeatherRequested({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}

class WeatherRefreshRequested extends WeatherEvent {
  final String city;

  const WeatherRefreshRequested({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}

///回调接口请求后得到的数据，及各种状态
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  final Weather weather;

  const WeatherLoadSuccess({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherLoadFailure extends WeatherState {}

///事件及回调的中间件
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherInitial());

  ///匹配到相应的事件，通过接口去获取数据
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield* _mapWeatherRequestedToState(event);
    } else if (event is WeatherRefreshRequested) {
      yield* _mapWeatherRefreshRequestedToState(event);
    }
  }

  Stream<WeatherState> _mapWeatherRequestedToState(
    WeatherRequested event,
  ) async* {
    yield WeatherLoadInProgress();
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoadSuccess(weather: weather);
    } catch (_) {
      yield WeatherLoadFailure();
    }
  }

  Stream<WeatherState> _mapWeatherRefreshRequestedToState(
    WeatherRefreshRequested event,
  ) async* {
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoadSuccess(weather: weather);
    } catch (_) {}
  }

  sayHello() {
    sleep(Duration(seconds: 10));
    print("11111");
    //sleep(Duration(seconds: 2));
    print("222222");
  }
}
