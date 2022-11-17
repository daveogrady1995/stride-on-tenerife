class WeatherResponse {
  final String cityName;
  final String cityTemp;
  final String cityWeather;
  final String weatherIcon;

  WeatherResponse(
      {this.cityName, this.cityTemp, this.cityWeather, this.weatherIcon});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    double cityTemp = json['main']['temp'];
    final cityTemp2 = cityTemp.round().toString();
    final cityWeather = json['weather'][0]['main'];
    final weatherIcon = json['weather'][0]['icon'];

    return WeatherResponse(
        cityName: cityName,
        cityTemp: cityTemp2,
        cityWeather: cityWeather,
        weatherIcon: weatherIcon);
  }
}
