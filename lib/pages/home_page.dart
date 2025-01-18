import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_model.dart';
import 'package:flutter_weather_app/pages/search_page.dart';
import 'package:flutter_weather_app/providers/weather_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // backgroundColor: Colors.blueAccent,
        backgroundColor:
            Provider.of<WeatherProvider>(context).weatherData == null
                ? Colors.lightBlueAccent.shade100
                : Provider.of<WeatherProvider>(context)
                    .weatherData!
                    .getThemeColor(),
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
      body: weatherData == null
          ? const Center(
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
            )
          : Container(
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
                    Provider.of<WeatherProvider>(context)
                            .cityName!
                            .capitalize() ??
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
            ),
    );
  }
}

extension on String {
  String? capitalize() {
    // ignore: unnecessary_this
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
