import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/cubits/weather_cubit/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(super.initialState);
  // WeatherCubit(WeatherState initialState) : super(initialState);
}
