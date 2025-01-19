import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(super.initialState, this.weatherService);
  // WeatherCubit(this.weatherService) : super(WeatherInitial());
  WeatherService weatherService;
  WeatherModel? weatherModel;
  String? cityName;
  String? wrong;

  Future<void> getWeather({required String cityName}) async {
    // emit(WeatherLoading());
    if (cityName.isEmpty) {
      wrong = "City Name Can Not Be Empty!, Try Again With A City Name.";
      emit(WeatherFailure());
    } else {
      try {
        emit(WeatherLoading());
        weatherModel = await weatherService.getWeatherData(cityName: cityName);
        emit(WeatherSuccess());
      } catch (e) {
        wrong = "City Not Found!";
        emit(WeatherFailure());
        log(e.toString());
      }
    }
  }
}
