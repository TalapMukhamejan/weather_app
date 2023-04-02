import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import '../services/weather.dart';
import '../widgets/info_columns.dart';

class HomePage extends StatefulWidget {
  final locationWeather;

  HomePage({this.locationWeather});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel weather = WeatherModel();
  int? temperature;
  String? weatherIcon;
  String? cityName;
  String? countryName;
  String? mainDescription;
  int? visibility;
  int? humidity;
  num? wind;

  final _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatedUI(widget.locationWeather);
  }

  void updatedUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'images/1000.png';
        cityName = 'No where';
        return;
      }
      double temp = weatherData['main']['temp'].toDouble();
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      mainDescription = weatherData['weather'][0]['main'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
      countryName = weatherData['sys']['country'];
      humidity = weatherData['main']['humidity'];
      wind = weatherData['wind']['speed'];
      visibility = weatherData['visibility'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SearchBar(
                                textController: _textController,
                                onSubmitted: (val) async {
                                  Navigator.pop(context);
                                  var weatherData =
                                      await weather.getCityWeather(val);
                                  updatedUI(weatherData);
                                  _textController.clear();
                                },
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF75757f),
                        ),
                      ),
                      Text(
                        '$cityName, $countryName',
                        style: TextStyle(
                          color: Color(0xFF75757f),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var weatherData = await weather.getLocationWeather();
                          updatedUI(weatherData);
                        },
                        child: Icon(
                          Icons.refresh,
                          color: Color(0xFF75757f),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Report',
                      style: kHeadlineThreeTextStyle,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 25,
                child: Image.asset(
                  weatherIcon!,
                  width: 250,
                ),
              ),
              Expanded(
                flex: 15,
                child: Column(
                  children: [
                    Text(
                      '$mainDescription',
                      style: kHeadlineThreeTextStyle,
                    ),
                    Text(
                      temperature.toString(),
                      style: kHeadlineNumberTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InfoColumn(
                          imagePath: 'images/humidity_2.png',
                          title: '$humidity%',
                          subtitle: 'Humidity'),
                    ),
                    Expanded(
                      child: InfoColumn(
                          imagePath: 'images/wind.png',
                          title: '$wind m/s',
                          subtitle: 'Wind speed'),
                    ),
                    Expanded(
                      child: InfoColumn(
                          imagePath: 'images/visibility_2.png',
                          title: '$visibility m',
                          subtitle: 'Visibility'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController textController;
  ValueChanged<String>? onSubmitted;

  SearchBar({required this.textController, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Container(
        height: 600,
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            onSubmitted: onSubmitted,
            style: TextStyle(color: Colors.white),
            controller: textController,
            decoration: InputDecoration(
              fillColor: Color(0xFF75757f),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Search your city',
              hintStyle: TextStyle(
                color: Color(0xFF75757f),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  textController.clear();
                },
                icon: Icon(
                  Icons.clear,
                  color: Color(0xFF75757f),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
