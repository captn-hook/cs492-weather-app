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
  processForecasts(forecastHourlyJsonData);

  // // get a set of all keys in the forecast and hourly forecast json data
  // Set<String> forecastKeys = forecastJsonData["properties"]["periods"][0].keys.toSet();
  // Set<String> forecastHourlyKeys = forecastHourlyJsonData["properties"]["periods"][0].keys.toSet();
  // Set<String> allKeys = forecastKeys.union(forecastHourlyKeys);

  // print(allKeys);
  return;
}

Future<Map<String, dynamic>> getJsonFromUrl(String url) async {
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}

void processForecasts(Map<String, dynamic> forecasts) {
  // TODO: pass the array of forcasts in from main
  // For loop through the forecasts and process each forecast with the
  // processForecast function below
  
  for (Map<String, dynamic> forecast in forecasts["properties"]["periods"]) {
    processForecast(forecast);
  }

}

void processForecast(Map<String, dynamic> forecast) {
  // TODO: Pass a forecast entry (either hourly or bidaily), and extract
  // The proper values that will be useful. i.e. temperature, shortForecast, longForecast
  // for now, don't return anything, just assign values for each
  // i.e. String shortForcast = "";

  // keys: number, name, startTime, endTime, isDaytime, temperature, temperatureUnit, temperatureTrend, probabilityOfPrecipitation, windSpeed, windDirection, icon, shortForecast, detailedForecast, dewpoint, relativeHumidity

  Map<String, dynamic> keys = {
    //"number": int,
    "name": String,
    "startTime": String,
    "endTime": String,
    "isDaytime": bool,
    "temperature": int,
    //"temperatureUnit": String,
    "temperatureTrend": String,
    "probabilityOfPrecipitation": Map<String, dynamic>,
    "windSpeed": String,
    "windDirection": String,
    "icon": String,
    "shortForecast": String,
    "detailedForecast": String,
    "dewpoint": Map<String, dynamic>,
    "relativeHumidity": Map<String, dynamic>
  };

  Map<String, dynamic> units = {
    "percent": "%",
    "degC": "°C",
    "m/s": "m/s",
    "degF": "°F",
    "w": "w"
  };

  for (String key in keys.keys) {
    // if the type is map, we need the value + unitCode : wmoUnit
    if (keys[key] == Map<String, dynamic>) {
      // check there is data for the key
      if (forecast[key] != null && forecast[key] != '') {
        String unit = units[forecast[key]["unitCode"].split(":")[1]];
        print("$key: ${forecast[key]["value"]} $unit");
      }
    } else {
      // check there is data for the key
      if (forecast[key] != null && forecast[key] != '') {
        print("$key: ${forecast[key]}");
      }
    }
  }
  print("\n");
}