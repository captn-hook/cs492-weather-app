import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;

class ForecastSummaryWidget extends StatelessWidget {
  const ForecastSummaryWidget({
    super.key,
    required forecast.Forecast currentForecast,
  }) : _forecast = currentForecast;

  final forecast.Forecast _forecast;

  Widget frameWidget(Widget child) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: update this widget to look better
    // Use flutter documentation to help you
    // Try add spacing and a border around the outside
    // Update the text as well, so the name, forecast, and temperature have different formatting
    return Column(
      children: [
        frameWidget(Text(_forecast.name??'', style: TextStyle(fontWeight: FontWeight.bold))),
        frameWidget(Row(children: [
          Text(_forecast.shortForecast??'', style: TextStyle(fontStyle: FontStyle.italic)),
          Text(' - '),
          Text("${_forecast.temperature.toString()??''}${_forecast.temperatureUnit??''}", style: TextStyle(fontWeight: FontWeight.bold)),
        ])),
      ],
    );
  }
}
