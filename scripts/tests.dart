import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main() async {
  String pointsUrl = "https://api.weather.gov/points/44.058,-121.31";
  Map<String, dynamic> pointsJsonData = await getJsonFromUrl(pointsUrl);


  String forecastUrl = pointsJsonData["properties"]["forecast"];
  String forecastHourlyUrl = pointsJsonData["properties"]["forecastHourly"];

  Map<String, dynamic> forecastJsonData = await getJsonFromUrl(forecastUrl);
  Map<String, dynamic> forecastHourlyJsonData = await getJsonFromUrl(forecastHourlyUrl);

  processForecasts(forecastJsonData);

  return;
}

Future<Map<String, dynamic>> getJsonFromUrl(String url) async {
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}

void processForecasts(Map<String, dynamic> forecasts){
  // TODO: pass the array of forcasts in from main
  // For loop through the forecasts and process each forecast with the
  // processForecast function below
  
  for (var forecast in forecasts["properties"]["periods"]){
    processForecast(forecast);
  }

}

void processForecast(Map<String, dynamic> forecast){
  // TODO: Pass a forecast entry (either hourly or bidaily), and extract
  // The proper values that will be useful. i.e. temperature, shortForecast, longForecast
  // for now, don't return anything, just assign values for each
  // i.e. String shortForcast = "";

  String shortForecast = forecast["shortForecast"];
  String longForecast = forecast["detailedForecast"];
  int temperature = forecast["temperature"];
  String temperatureUnit = forecast["temperatureUnit"];
  String startTime = forecast["startTime"];
  String endTime = forecast["endTime"];
  String name = forecast["name"];
  int number = forecast["number"];
  String windSpeed = forecast["windSpeed"];
  String windDirection = forecast["windDirection"];
  String icon = forecast["icon"];

  // print out the values for now
  print("Short Forecast: $shortForecast");
  print("Long Forecast: $longForecast");
  print("Temperature: $temperature $temperatureUnit");
  print("Start Time: $startTime");
  print("End Time: $endTime");
  print("Name: $name");
  print("Number: $number");
  print("Wind Speed: $windSpeed");

}