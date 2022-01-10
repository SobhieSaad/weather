import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class WetherAPI extends StatefulWidget {
  const WetherAPI({Key? key}) : super(key: key);

  @override
  State<WetherAPI> createState() => _WetherAPIState();
}

class _WetherAPIState extends State<WetherAPI> {
  final Geolocator geolocator = Geolocator();
  Position _currentPosition;
  String _currentAddress;
  // ignore: non_constant_identifier_names
  final String api_key = "965ec8c752a72918604e7b2fa8d1d6ea";
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  void getWetherdata() async {
    http.Response response = await http.get(Uri.parse(
        'https://samples.openweathermap.org/data/2.5/forecast?q=London,us&mode=xml&appid=' +
            api_key));
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
