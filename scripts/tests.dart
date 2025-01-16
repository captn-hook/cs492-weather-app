import './forecast.dart' as forecast;

void printList(List<dynamic> list){
  for (dynamic item in list){
    print(item);
  }
}

Future<void> main() async {
  // testing with Bend, OR coordinates
  double lat = 44.05;
  double lon = -121.31;
  
  // new york: 40.7128° N, 74.0060° W
  // miami: 25.7617° N, 80.1918° W
  // denver: 39.7392° N, 104.9903° W
  // san francisco: 37.7749° N, 122.4194° W
  // seattle: 47.6061° N, 122.3328° W
  
  Map<String, dynamic> points = {
    'bend': [44.05, -121.31],
    'new york': [40.7128, -74.0060],
    'miami': [25.7617, -80.1918],
    'denver': [39.7392, -104.9903],
    'san francisco': [37.7749, -122.4194],
    'seattle': [47.6061, -122.3328]
  };

  // Create a for loop that will generate forecasts arrays for each city
  for (String city in points.keys) {
    lat = points[city][0];
    lon = points[city][1];

    print("Forecast for $city");
    print("Daytime Forecast:");
    dynamic f0 = await forecast.getForecastFromPoints(lat, lon);
    printList(f0);
    print("\nHourly Forecast:");
    dynamic f1 = await forecast.getForecastHourlyFromPoints(lat,lon);
    printList(f1);
    print("\n");
  }
}