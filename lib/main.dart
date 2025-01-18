import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/pages/home_page.dart';
import 'package:flutter_weather_app/services/weather_service.dart';
import 'cubits/weather_cubit/weather_state.dart';

void main() {
  runApp(BlocProvider(
      create: (BuildContext context) {
        return WeatherCubit(WeatherInitial(), WeatherService());
      },
      child: WeatherApp()));
}

// ignore: must_be_immutable
class WeatherApp extends StatelessWidget {
  WeatherApp({super.key});
  WeatherModel? weather;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Provider.of<WeatherProvider>(context).weatherData == null
      //         ? Colors.lightBlueAccent.shade700
      //         : Provider.of<WeatherProvider>(context)
      //             .weatherData!
      //             .getThemeColor(),
      //   ),
      //   useMaterial3: true,
      //   // floatingActionButtonTheme: const FloatingActionButtonThemeData(),
      // ),
      home: HomePage(),
    );
  }
}
