import 'package:flutter/material.dart';
import 'package:weather/src/models/forcast.dart';
import 'package:weather/src/models/location.dart';
import 'package:weather/src/widgets/weatherBox.dart';

Widget forcastViewsHourly(Location location) {
  Forecast? _forcast;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forcast = snapshot.data as Forecast;
        if (_forcast == null) {
          return const Text("Error getting weather");
        } else {
          return hourlyBoxes(_forcast!);
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}
