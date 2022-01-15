import 'package:flutter/material.dart';
import 'package:weather/src/models/forcast.dart';
import 'package:weather/src/models/location.dart';
import 'package:weather/src/widgets/weatherBox.dart';

Widget forcastViewsDaily(Location location) {
  Forecast? _forcast;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forcast = snapshot.data as Forecast?;
        if (_forcast == null) {
          return Text("Error getting weather");
        } else {
          return dailyBoxes(_forcast!);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}
