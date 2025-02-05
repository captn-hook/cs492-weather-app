import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:weatherapp/scripts/time.dart';

class Forecast{
  final String? name;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String windSpeed;
  final String windDirection;
  final String shortForecast;
  final String? detailedForecast;
  final int? precipitationProbability;
  final int? humidity;
  final num? dewpoint;
  final DateTime startTime;
  final DateTime endTime;
  final String? tempHighLow;

  Forecast({
    required this.name,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.windSpeed,
    required this.windDirection,
    required this.shortForecast,
    required this.detailedForecast,
    required this.precipitationProbability,
    required this.humidity,
    required this.dewpoint,
    required this.startTime,
    required this.endTime,
    required this.tempHighLow,
  });

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
      name: json["name"].isNotEmpty ? json["name"] : null,
      isDaytime: json["isDaytime"],
      temperature: json["temperature"],
      temperatureUnit: json["temperatureUnit"],
      windSpeed: json["windSpeed"],
      windDirection: json["windDirection"],
      shortForecast: json["shortForecast"],
      detailedForecast: json["detailedForecast"].isNotEmpty ? json["detailedForecast"]: null ,
      precipitationProbability: json["probabilityOfPrecipitation"]["value"],
      humidity: json["relativeHumidity"] != null ? json["relativeHumidity"]["value"] : null,
      dewpoint: json["dewpoint"]?["value"],
      startTime: DateTime.parse(json["startTime"]).toLocal(),
      endTime: DateTime.parse(json["endTime"]).toLocal(),
      tempHighLow: null
    );
  }

  @override
  String toString(){
    return "name: ${name ?? "None"}\n"
          "isDaytime: ${isDaytime ? "Yes" : "No"}\n"
          "temperature: $temperature\n"
          "temperatureUnit: $temperatureUnit\n"
          "windSpeed: $windSpeed\n"
          "windDirection: $windDirection\n"
          "shortForecast: $shortForecast\n"
          "detailedForecast: $detailedForecast\n"
          "precipitationProbability: ${precipitationProbability ?? "None"}\n"
          "humidity: ${humidity ?? "None"}\n"
          "dewpoint: ${dewpoint ?? "None"}\n"
          "startTime: ${startTime.toLocal()}\n"
          "endTime: ${endTime.toLocal()}\n"
          "tempHighLow: ${tempHighLow ?? "None"}";
  }

  String getIconPath() {
    Map<String, String> iconMap = {
      "sunny": "assets/weather_icons/sunny.svg",
      "mostly sunny": "assets/weather_icons/mostly_sunny.svg",
      "partly sunny": "assets/weather_icons/partly_clear.svg",
      "partly cloudy": "assets/weather_icons/partly_cloudy.svg",
      "mostly cloudy": "assets/weather_icons/mostly_cloudy.svg",
      "cloudy": "assets/weather_icons/cloudy.svg",
      "clear": "assets/weather_icons/clear.svg",
      "mostly clear": "assets/weather_icons/mostly_clear.svg",
      "patchy fog": "assets/weather_icons/fog.svg",
      "areas of fog": "assets/weather_icons/fog.svg",
      "slight chance light snow": "assets/weather_icons/snow_showers.svg",
      "chance light snow": "assets/weather_icons/snow_showers.svg",
      "light snow likely": "assets/weather_icons/snow_showers.svg",
      "light snow": "assets/weather_icons/snow_showers.svg",
      "heavy snow likely": "assets/weather_icons/heavy_snow.svg",
      "heavy snow": "assets/weather_icons/heavy_snow.svg",
      "snow": "assets/weather_icons/snow_showers.svg",
      "slight chance light rain": "assets/weather_icons/droplet_light.svg",
      "chance light rain": "assets/weather_icons/droplet_light.svg",
      "light rain likely": "assets/weather_icons/droplet_light.svg",
      "light rain": "assets/weather_icons/droplet_light.svg",
      "rain": "assets/weather_icons/droplet_clear.svg",
      "slight chance rain and snow": "assets/weather_icons/wintry_mix.svg",
      "chance rain and snow": "assets/weather_icons/wintry_mix.svg",
      "rain and snow likely": "assets/weather_icons/wintry_mix.svg",
      "rain and snow": "assets/weather_icons/wintry_mix.svg",
      "patchy blowing dust": "assets/weather_icons/dust.svg",
      "slight chance freezing drizzle": "assets/weather_icons/drizzle.svg",
      "chance freezing drizzle": "assets/weather_icons/drizzle.svg",
      "freezing drizzle likely": "assets/weather_icons/drizzle.svg",
      "slight chance rain showers": "assets/weather_icons/showers.svg",
      "chance rain showers": "assets/weather_icons/showers.svg",
      "rain showers likely": "assets/weather_icons/showers.svg",
      "rain showers": "assets/weather_icons/showers.svg",
      "slight chance showers and thunderstorms": "assets/weather_icons/strong_tstorms.svg",
      "chance showers and thunderstorms": "assets/weather_icons/strong_tstorms.svg",
      "showers and thunderstorms likely": "assets/weather_icons/strong_tstorms.svg",
      "showers and thunderstorms": "assets/weather_icons/strong_tstorms.svg",
      "patchy blowing snow": "assets/weather_icons/blowing_snow.svg",
      "slight chance snow showers": "assets/weather_icons/snow_showers.svg",
      "chance snow showers": "assets/weather_icons/snow_showers.svg",
      "chance sleet": "assets/weather_icons/sleet_hail.svg",
      "chance freezing rain": "assets/weather_icons/icy.svg",
      "freezing rain likely": "assets/weather_icons/icy.svg",
      "freezing rain": "assets/weather_icons/icy.svg",
      "areas of frost": "assets/weather_icons/fog.svg"
    };

    for (String key in iconMap.keys) {
      if (shortForecast.toLowerCase().contains(key)) {
        return iconMap[key]!;
      }
    }
    return "assets/weather_icons/question.svg";
  }
}

Future<List<Forecast>> getForecastFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecast URL from the response json
  String forecastUrl = pointsJson["properties"]["forecast"];

  // make a request to the forecastJson url and decode the json data
  Map<String, dynamic> forecastJson = await getRequestJson(forecastUrl);
  return processForecasts(forecastJson["properties"]["periods"]);
}

Future<List<Forecast>> getForecastHourlyFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecastHourly URL from the response json
  String forecastHourlyUrl = pointsJson["properties"]["forecastHourly"];

  // make a request to the forecastHourlyJson url and decode the json data
  Map<String, dynamic> forecastHourlyJson = await getRequestJson(forecastHourlyUrl);
  return processForecasts(forecastHourlyJson["properties"]["periods"]);
}

List<Forecast> processForecasts(List<dynamic> forecasts){
  List<Forecast> forecastObjs = [];
  for (dynamic forecast in forecasts){
    forecastObjs.add(Forecast.fromJson(forecast));
  }
  return forecastObjs;
}

Future<Map<String, dynamic>> getRequestJson(String url) async{
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}


Forecast getForecastDaily(Forecast forecast1, Forecast forecast2){
  String tempHighLow = getTempHighLow(forecast1.temperature, forecast2.temperature, forecast1.temperatureUnit);

  return Forecast(
    name: equalDates(DateTime.now(), forecast1.startTime) ? "Today" : forecast1.name, 
    isDaytime: forecast1.isDaytime, 
    temperature: forecast1.temperature, 
    temperatureUnit: forecast1.temperatureUnit, 
    windSpeed: forecast1.windSpeed, 
    windDirection: forecast1.windDirection, 
    shortForecast: forecast1.shortForecast, 
    detailedForecast: forecast1.detailedForecast, 
    precipitationProbability: forecast1.precipitationProbability, 
    humidity: forecast1.humidity, 
    dewpoint: forecast1.dewpoint, 
    startTime: forecast1.startTime, 
    endTime: forecast2.endTime, 
    tempHighLow: tempHighLow);

}

String getTempHighLow(int temp1, int temp2, String tempUnit){
  if (temp1 < temp2){
    return "$temp1°$tempUnit/$temp2°$tempUnit";
  }
  else {
    return "$temp2°$tempUnit/$temp1°$tempUnit";
  }

}