import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:flutter_weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(super.initialState, this.weatherService);
  // WeatherCubit(WeatherState initialState) : super(initialState);
  WeatherService weatherService;
  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
      await weatherService.getWeatherData(cityName: cityName);
      emit(WeatherSuccess());
    } on Exception catch (e) {
      log(e.toString());
      emit(WeatherFailure());
    }
  }
}
