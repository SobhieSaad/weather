import 'package:flutter/material.dart';
import 'package:weather/src/models/weather.dart';

Widget weatherDetailsBox(Weather _weather) {
  return Container(
    padding: const EdgeInsets.only(left: 15, top: 15, bottom: 25, right: 15),
    margin: const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 15),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ]),
    child: Row(
      children: [
        Expanded(
            child: Column(
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
                child: const Text(
              "Wind",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey),
            )),
            // ignore: avoid_unnecessary_containers
            Container(
                child: Text(
              "${_weather.wind} km/h",
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black),
            ))
          ],
        )),
        Expanded(
            child: Column(
          children: [
            Container(
                child: const Text(
              "Humidity",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey),
            )),
            Container(
                child: Text(
              "${_weather.humidity?.toInt()}%",
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black),
            ))
          ],
        )),
        Expanded(
            child: Column(
          children: [
            Container(
                child: const Text(
              "Pressure",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.grey),
            )),
            Container(
                child: Text(
              "${_weather.pressure} hPa",
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.black),
            ))
          ],
        ))
      ],
    ),
  );
}
