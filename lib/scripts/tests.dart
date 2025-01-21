import 'forecast.dart' as forecast;
import 'location.dart' as location;

// void main() async {
//   testForecast();
// }

void testLocation() async {

  // TODO: Create a list of Map<String, String>
  // Add several (at least 5) city, state, zip Map<String, String> to the list
  // iterate through the list, calling location.getLocationFromAddress function for each iteration
  // passing in the city, state, and zip.
  // Debug with a breakpoint after the return (you can use a placeholder like print("test") for your breakpoint)
  // Check to ensure each location returns as expected through debugging. 

  location.getLocationFromAddress("oijeqofwkjfla", "asdfsd", "98839829382");

  List<Map<String, String>> locations = [
    {"city": "Bend", "state": "OR", "zip": "97701"},
    {"city": "New York", "state": "NY", "zip": "10001"},
    {"city": "Chicago", "state": "IL", "zip": "60601"},
    {"city": "Miami", "state": "FL", "zip": "33101"},
    {"city": "Albuquerque", "state": "NM", "zip": "87101"}
  ];

  for (Map<String, String> loc in locations){
    print("Getting location for ${loc["city"]}, ${loc["state"]} ${loc["zip"]}");
    var loca = await location.getLocationFromAddress(loc["city"]!, loc["state"]!, loc["zip"]!);
    // print the location as a string
    print("Location:");
    print(loca.toString());

    // I/flutter ( 3174): Location:
    // I/flutter ( 3174): City: Bend, State: Oregon, Zip: 97703, Lat: 44.0581728, Lon: -121.31530959999999
    // I/flutter ( 3174): Getting location for New York, NY 10001
    // I/flutter ( 3174): Location:
    // I/flutter ( 3174): City: New York, State: New York, Zip: 10001, Lat: 40.753685399999995, Lon: -73.9991637
    // I/flutter ( 3174): Getting location for Chicago, IL 60601
    // I/flutter ( 3174): Location:
    // I/flutter ( 3174): City: Chicago, State: Illinois, Zip: 60601, Lat: 41.8839927, Lon: -87.61970559999999
    // I/flutter ( 3174): Getting location for Miami, FL 33101
    // I/flutter ( 3174): Location:
    // I/flutter ( 3174): City: Miami, State: Florida, Zip: 33101, Lat: 25.7783254, Lon: -80.1990136
    // I/flutter ( 3174): Getting location for Albuquerque, NM 87101
    // I/flutter ( 3174): Location:
    // I/flutter ( 3174): City: Albuquerque, State: New Mexico, Zip: 87101, Lat: 35.0720392, Lon: -106.64663060000001
  }  

}


void testForecast() async {
// testing with Bend, OR coordinates
  // double lat = 44.05;
  // double lon = -121.31;
  List<List<double>> coords = [
    [44.05, -121.31],
    [40.71, -74.006],
    [41.878, -87.629],
    [25.7617, -80.1918],
    [35.0844, -106.65]
  ];

  for (List<double> coord in coords){
    List<forecast.Forecast> forecasts = await forecast.getForecastFromPoints(coord[0], coord[1]);
    List<forecast.Forecast> forecastsHourly = await forecast.getForecastHourlyFromPoints(coord[0],coord[1]);
  }
}