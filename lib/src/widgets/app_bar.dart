import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/src/models/location.dart';
import 'package:weather/src/widgets/get_user_location.dart';

Widget createAppBar(
    List<Location> locations, Location location, BuildContext context) {
  return Container(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
      margin:
          const EdgeInsets.only(top: 2, left: 15.0, bottom: 15.0, right: 15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) {
            return const GetCurrentLocaitonDetails();
          }));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: '${location.city}, ',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  TextSpan(
                      text: location.country,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16)),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 24.0,
              semanticLabel: 'Tap to change location',
            ),
          ],
        ),
      ));
}
