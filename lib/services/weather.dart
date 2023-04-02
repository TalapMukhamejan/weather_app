import 'location.dart';
import 'networking.dart';

const apiKey = 'e50fce096a2befc6bbc802cbfda14dd4';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    // print('$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    print(weatherData);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'images/300.png';
    } else if (condition < 500) {
      return 'images/400.png';
    } else if (condition < 600) {
      return 'images/500.png';
    } else if (condition < 700) {
      return 'images/600.png';
    } else if (condition < 800) {
      return 'images/700.png';
    } else if (condition == 800) {
      return 'images/800.png';
    } else if (condition <= 804) {
      return 'images/900.png';
    } else {
      return 'images/1000.png';
    }
  }
}
