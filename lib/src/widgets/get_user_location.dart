import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GetCurrentLocaitonDetails extends StatefulWidget {
  const GetCurrentLocaitonDetails({Key? key}) : super(key: key);

  @override
  State<GetCurrentLocaitonDetails> createState() =>
      _GetCurrentLocaitonDetailsState();
}

class _GetCurrentLocaitonDetailsState extends State<GetCurrentLocaitonDetails> {
  LatLng initialcameraposition = const LatLng(0, 0);
  late GoogleMapController _controller;
  Location location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    if (initialcameraposition.latitude == 0 &&
        initialcameraposition.longitude == 0) {
      _controller = _cntlr;
      location.onLocationChanged.listen((l) {
        // ignore: avoid_print
        setState(() {
          initialcameraposition =
              LatLng(l.latitude as double, l.longitude as double);
        });
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(l.latitude as double, l.longitude as double),
                zoom: 12),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: initialcameraposition),
            mapType: MapType.normal,
            onMapCreated: initialcameraposition.latitude == 0 &&
                    initialcameraposition.longitude == 0
                ? _onMapCreated
                : null,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ],
      ),
    );
  }
}
