import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:weather/src/home.dart';
import 'package:weather/src/models/CityCountry.dart';
import 'package:weather/src/models/location.dart' as locationModel;
import 'package:weather/src/settings/settings_controller.dart';
import 'package:weather/src/widgets/get_city_country_by_cords.dart';
import 'package:weather/src/widgets/weatherBox.dart';

class GetCurrentLocaitonDetails extends StatefulWidget {
  SettingsController controller;
  List<locationModel.Location> locationsList = [];
  GetCurrentLocaitonDetails(
      {Key? key, required this.controller, required locationsList})
      : super(key: key);

  @override
  State<GetCurrentLocaitonDetails> createState() =>
      _GetCurrentLocaitonDetailsState();
}

class _GetCurrentLocaitonDetailsState extends State<GetCurrentLocaitonDetails> {
  LatLng initialcameraposition = const LatLng(0, 0);
  Location location = Location();
  Location currentLocation = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  LatLng? position;
  LatLng newLocation = const LatLng(1, 1);
  LatLng? initialCameraTarget;
  LatLng? newCameraTarget;
  Set<Polyline> _polylines = {};
  List<Marker> allMarkers = [];
  int count = 0;
  // ignore: unused_field
  GoogleMapController? _mapController;
  List<LatLng> polylineCoordinates = [];
  var cc;
  // ignore: prefer_typing_uninitialized_variables
  var _child;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    _child = Container();
    cc = null;
    getLocation(context);
  }

  Future<void> getLocation(context) async {
    await Future.delayed(const Duration(seconds: 1));

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {
      position = LatLng(_locationData?.latitude as double,
          _locationData?.longitude as double);
      if (newLocation != position) {
        _child = buildGoogleMap();
        initialCameraTarget = position;
        newCameraTarget = position;
        newLocation = position!;
        gitCityAndCountryByCordenates(
                position!.latitude.toString(), position!.longitude.toString())
            .then((result) {
          setState(() {
            cc = result;
          });
        });
      }
    });
  }

  GoogleMap buildGoogleMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: position!,
        zoom: 12,
      ),
      myLocationButtonEnabled: true,
      compassEnabled: true,
      polylines: _polylines,
      mapType: MapType.normal,
      markers: Set.from(allMarkers),
      myLocationEnabled: true,
      onCameraMove: (value) async {
        initialCameraTarget = value.target;
      },
      onCameraIdle: () async {
        String? lat = initialCameraTarget?.latitude.toString();
        String? lon = initialCameraTarget?.longitude.toString();
        gitCityAndCountryByCordenates(lat!, lon!).then((result) {
          setState(() {
            cc = result;
          });
        });
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (cc == null) {
      return const Material(
        child: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    // ignore: sized_box_for_whitespace
    return Material(
      child: Stack(children: <Widget>[
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 100,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
                  child: Column(
                    children: [
                      Text(
                        cc!.city.toString() + ", " + cc!.country.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 2,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage(
                                        controller: widget.controller,
                                        locations: [
                                          locationModel.Location(
                                              city: cc.city,
                                              country: cc.country,
                                              lat: (initialCameraTarget
                                                      ?.latitude)
                                                  .toString(),
                                              lon: (initialCameraTarget
                                                      ?.longitude)
                                                  .toString())
                                        ])),
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.lightBlue,
                          ),
                          child: const Center(
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            )),
        //Map
        Positioned(
          top: 120,
          bottom: 0,
          left: 0,
          right: 0,
          child: _child,
        ),
      ]),
    );
  }
}
