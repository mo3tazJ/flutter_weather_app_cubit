import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:flutter_weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/pages/search_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  WeatherModel? weatherData;
  String? wrong;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // backgroundColor: Colors.blueAccent,
        // backgroundColor:
        //     Provider.of<WeatherProvider>(context).weatherData == null
        //         ? Colors.lightBlueAccent.shade100
        //         : Provider.of<WeatherProvider>(context)
        //             .weatherData!
        //             .getThemeColor(),
        title: const Text("Weather App"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const LoadingPage();
          } else if (state is WeatherSuccess) {
            weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return SuccessPage(weatherData: weatherData);
          } else if (state is WeatherFailure) {
            wrong = BlocProvider.of<WeatherCubit>(context).wrong;
            return FailurePage(
              wrong: wrong,
            );
          } else {
            return const DefaultPage();
          }
        },
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orangeAccent,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          weatherData!.getThemeColor(),
          weatherData!.getThemeColor()[300]!,
          weatherData!.getThemeColor()[100]!,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName!.capitalize() ??
                "No City",
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "updated at  ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(weatherData!.getImage()),
              Text(
                "${weatherData!.temp.toInt()}",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Column(
                children: [
                  Text(
                    "Max: ${weatherData!.maxTemp.toInt()}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Min: ${weatherData!.minTemp.toInt()}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            weatherData?.weatherStateName ??
                "", // Or: weatherData!.weatherStateName , Because the null check at the body beginning
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(
            flex: 6,
          ),
        ],
      ),
    );
  }
}

class DefaultPage extends StatelessWidget {
  const DefaultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "there is no weather 😔 start",
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          Text(
            "searching now 🔍",
            style: TextStyle(
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class FailurePage extends StatelessWidget {
  FailurePage({super.key, this.wrong});
  String? wrong;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          "$wrong 😔",
          style: const TextStyle(
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

extension StringExtension on String {
  String? capitalize() {
    // ignore: unnecessary_this
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
