import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:weather/src/models/weather.dart';

const String apiKey = "965ec8c752a72918604e7b2fa8d1d6ea";
String weatherApi =
    "https://api.openweathermap.org/data/2.5/weather?units=metric";
String forcastAPI =
    'https://api.openweathermap.org/data/2.5/weather?q=London&appid=';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint =
        Uri.parse(weatherApi + "&q=" + location! + "&appid=" + apiKey);

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);

    return Weather.fromJson(body);
  }
}

// class WetherAPI extends StatefulWidget {
//   const WetherAPI({Key? key}) : super(key: key);

//   @override
//   State<WetherAPI> createState() => _WetherAPIState();
// }

// class _WetherAPIState extends State<WetherAPI> {
//   final Geolocator geolocator = Geolocator();
//   late Position _currentPosition;
//   late String _currentAddress;
//   // ignore: non_constant_identifier_names
// @override
//   void initState() {
//     super.initState();
//     // _getCurrentLocation();
//   }

//   // _getCurrentLocation() {
//   //   geolocator
//   //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//   //       .then((Position position) {
//   //     setState(() {
//   //       _currentPosition = position;
//   //     });

//   //     _getAddressFromLatLng();
//   //   }).catchError((e) {
//   //     print(e);
//   //   });
//   // }

//   // _getAddressFromLatLng() async {
//   //   try {
//   //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
//   //         _currentPosition.latitude, _currentPosition.longitude);

//   //     Placemark place = p[0];

//   //     setState(() {
//   //       _currentAddress =
//   //           "${place.locality}, ${place.postalCode}, ${place.country}";
//   //     });
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }

//   void getWetherdata() async {
//     http.Response response = await http.get(Uri.parse(weatherApi + api_key));
//     if (response.statusCode == 200) {
//       String data = response.body;
//       print(data);
//     } else {
//       print(response.statusCode);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
