class WeatherModel {
  final String date;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherStateName;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherStateName});
  factory WeatherModel.fromJson(dynamic data) {
    var targetedData = data["forecast"]["forecastday"][0]["day"];
    return WeatherModel(
      date: data["location"]['localtime'],
      temp: targetedData["avgtemp_c"],
      maxTemp: targetedData["maxtemp_c"],
      minTemp: targetedData["mintemp_c"],
      weatherStateName: targetedData["condition"]["text"],
    );
  }

  String getImage() {
    if (weatherStateName == 'Sunny' || weatherStateName == 'Clear') {
      return "assets/images/clear.png";
    } else if (weatherStateName == 'Partly cloudy' ||
        weatherStateName == 'Cloudy' ||
        weatherStateName.contains("loud") ||
        weatherStateName == 'Mist') {
      return "assets/images/cloudy.png";
    } else if (weatherStateName.contains("hunder")) {
      return "assets/images/thunderstorm.png";
    } else if (weatherStateName.contains("now")) {
      return "assets/images/snow.png";
    } else if (weatherStateName.contains("ain")) {
      return "assets/images/rainy.png";
    } else {
      return "assets/images/clear.png";
    }
  }

  @override
  String toString() {
    return "$weatherStateName \nMax temp: $maxTemp \nMin temp: $minTemp";
  }
}
