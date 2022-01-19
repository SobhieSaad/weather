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
    _controller = _cntlr;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(l.latitude as double, l.longitude as double),
              zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
