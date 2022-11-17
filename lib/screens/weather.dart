import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:masterPiece/models/weatherLocation.dart';
import 'dart:convert';
import 'dart:io';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _cityTextController = TextEditingController();
  String temperature;
  String location = 'Canary Islands';
  int woeid = 773692;
  String weather = 'clear';
  String abbreviation = '';
  String errorMessage = '';
  String searchApiUrl =
      'https://www.metaweather.com/api/location/search/?query=';
  String locationApiUrl = 'https://www.metaweather.com/api/location/';

  WeatherResponse weatherResponse;
  String weatherImage = "clear";

  initState() {
    super.initState();
    getWeather();
  }

  void fetchSearch(String input) async {
    /*try {
      var queryParameters = {
        'key': APIKeys().consumerKey,
        'input': 'Car Rental Tenerife',
        'inputtype': 'textquery',
        'fields': 'photos,formatted_address,name,opening_hours,rating',
      };
      var uri = Uri.https('maps.googleapis.com',
          'maps/api/place/findplacefromtext/json', queryParameters);
      //var response = await http.get(uri);
      //var result2 = json.decode(response.body);

      var searchResult = await http.get(searchApiUrl + input);
      var result = json.decode(searchResult.body)[0];
      var test = '';

      setState(() {
        location = result["title"];
        woeid = result["woeid"];
        errorMessage = '';
      });
    } catch (error) {
      setState(() {
        errorMessage = "Sorry. we don't have data about this location :(";
      });
    }*/
  }

  void getWeather() async {
    try {
      final queryParameters = {
        'q': this.location,
        'appid': '6599713274fbb3a4be67bf6293b9d113',
        'units': 'metric'
      };

      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);

      final response = await http.get(uri);

      Map<String, dynamic> weatherLocation = jsonDecode(response.body);
      var location = WeatherResponse.fromJson(weatherLocation);

      setState(() {
        errorMessage = '';

        this.weatherResponse = location;
        determineWeatherBackground();
      });
    } catch (error) {
      setState(() {
        errorMessage = "Sorry. we don't have data about this location :(";
      });
    }
  }

  void _search() {
    this.location = _cityTextController.text;
    getWeather();
  }

  determineWeatherBackground() {
    switch (weatherResponse.weatherIcon) {
      case "01d":
        {
          weatherImage = "clear";
        }
        break;

      case "02d":
        {
          weatherImage = "lightcloud";
        }
        break;

      case "03d":
        {
          weatherImage = "lightcloud";
        }
        break;

      case "04d":
        {
          weatherImage = "lightcloud";
        }
        break;

      case "09d":
        {
          weatherImage = "showers";
        }
        break;

      case "10d":
        {
          weatherImage = "showers";
        }
        break;

      case "11d":
        {
          weatherImage = "thunderstorm";
        }
        break;

      case "13d":
        {
          weatherImage = "snow";
        }
        break;

      default:
        {
          weatherImage = "lightcloud";
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/${this.weatherImage}.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: weatherResponse == null
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(children: [
                    Flexible(
                        flex: 1,
                        child: Row(children: [
                          IconButton(
                            padding: EdgeInsets.only(
                                left: 0, top: 40, right: 0, bottom: 0),
                            icon: const Icon(Icons.arrow_back_ios),
                            iconSize: 30,
                            tooltip: 'Go Back',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ])),
                    Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Center(
                                        child: Image.network(
                                          'http://openweathermap.org/img/wn/${weatherResponse.weatherIcon}@2x.png',
                                          width: 100,
                                        ),
                                      ),
                                      Center(
                                          child: Text(
                                              weatherResponse.cityTemp + ' °C',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 60))),
                                      Text(location,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40))
                                    ],
                                  ),
                                  SizedBox(height: 80),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          width: 300,
                                          child: TextField(
                                              controller: _cityTextController,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Search another location...',
                                                hintStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                                prefixIcon: Icon(
                                                    Icons.search_outlined,
                                                    color: Colors.white),
                                              ))),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                          onPressed: _search,
                                          child: const Text('Search'),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(60, 40),
                                          )),
                                      SizedBox(height: 20),
                                      Text(
                                        errorMessage,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              Platform.isAndroid ? 15.0 : 15.0,
                                        ),
                                      )
                                    ],
                                  )
                                ])
                          ],
                        ))
                  ]))),
    );
  }
}
