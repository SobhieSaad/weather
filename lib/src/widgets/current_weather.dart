import 'package:flutter/material.dart';

Widget currentWeather(IconData icon, String temp, String locaiton) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.orange,
          size: 64.0,
        ),
        const SizedBox(
          height: 64,
        ),
        Text(
          temp,
          style: const TextStyle(fontSize: 46.0),
        ),
        const SizedBox(
          height: 64,
        ),
        Text(
          locaiton,
          style: TextStyle(fontSize: 18.0, color: Colors.grey[400]),
        ),
      ],
    ),
  );
}
