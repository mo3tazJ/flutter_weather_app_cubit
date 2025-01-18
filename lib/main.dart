import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/pages/home_page.dart';
import 'package:flutter_weather_app/providers/weather_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) {
        return WeatherProvider();
      },
      child: WeatherApp()));
}

// ignore: must_be_immutable
class WeatherApp extends StatelessWidget {
  WeatherApp({super.key});
  WeatherModel? weather;
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
