import 'package:flutter/material.dart';
import 'package:weather/src/api/open_weather_api.dart';
import 'package:weather/src/models/weather.dart';
import 'package:weather/src/settings/settings_controller.dart';
import 'package:weather/src/widgets/additional_information.dart';
import 'package:weather/src/widgets/current_weather.dart';

class HomePage extends StatefulWidget {
  SettingsController controller;
  HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();

  Weather? data;
  Future<void> getData() async {
    data = await client.getCurrentWeather("Syria");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            'Weather with tasks app',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: Colors.black,
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  currentWeather(
                    Icons.wb_sunny_rounded,
                    "${data!.temp}",
                    "${data!.cityName}",
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Additional information",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Color(0xdd212121),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  additionlInformation(
                    "${data!.wind}",
                    "${data!.humidity}",
                    "${data!.pressure}",
                    "${data!.feels_like}",
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        )
        // bottomNavigationBar: BottomNavigationBar(
        //   items: [],
        // ),
        );
  }
}
