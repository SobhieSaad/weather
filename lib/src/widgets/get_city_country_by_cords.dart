import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/src/models/CityCountry.dart';

Future<CityCountry> gitCityAndCountryByCordenates(
    String lat, String lon) async {
  String countryNameUrl =
      "https://api.opencagedata.com/geocode/v1/json?q=$lat+$lon&key=5c6f7ef3ee5e401aa0de7bef27feb5bb";

  var countryUrlResponse = await http
      .get(Uri.parse(countryNameUrl), headers: {"Accept": "application/json"});

  var components =
      json.decode(countryUrlResponse.body)["results"][0]["components"];
  // ignore: prefer_typing_uninitialized_variables
  var city;
  try {
    city = components["city"];
  } catch (e) {
    city = "No city detected please move the map";
  }
  var country = components["country"];
  return CityCountry(country, city);
}
