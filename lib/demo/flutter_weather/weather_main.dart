import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:start_app/demo/flutter_weather/blocs/settings_bloc.dart';
import 'package:start_app/demo/flutter_weather/blocs/theme_bloc.dart';
import 'package:start_app/demo/flutter_weather/blocs/weather_bloc.dart';
import 'package:start_app/demo/flutter_weather/repositories/weather_api_client.dart';
import 'package:start_app/demo/flutter_weather/repositories/weather_repository.dart';
import 'package:start_app/demo/flutter_weather/weather_bloc_observer.dart';
import 'package:start_app/demo/flutter_weather/widgets/weather.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();
  //初始化api
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
      ],
      child: App(weatherRepository: weatherRepository),
    ),
  );
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Flutter Weather',
          theme: themeState.theme,
          home: BlocProvider(
            create: (context) => WeatherBloc(
              weatherRepository: weatherRepository,
            ),
            child: Weather(),
          ),
        );
      },
    );
  }
}
