import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/cubits/weather_cubit/weather_cubit.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  String? cityName;
  String? wrong;
  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade100,
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Search a City"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            obscureText: false,
            autofocus: true,
            onChanged: (data) {
              cityName = data;
              log(cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
            },
            onFieldSubmitted: (value) async {
              cityName = value;
              log("from textfield onSubmitted: city name = $cityName");
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              BlocProvider.of<WeatherCubit>(context)
                  .getWeather(cityName: cityName!);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
              labelText: "Search ...",
              suffixIcon: GestureDetector(
                child: const Icon(Icons.search),
                onTap: () async {
                  cityName = BlocProvider.of<WeatherCubit>(context).cityName;
                  log("from icon ontap: city name = $cityName");
                  BlocProvider.of<WeatherCubit>(context)
                      .getWeather(cityName: cityName!);
                  Navigator.pop(context);
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hintText: "Enter a City Name",
            ),
            showCursor: true,
          ),
        ),
      ),
    );
  }
}
