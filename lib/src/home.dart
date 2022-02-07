import 'package:flutter/material.dart';
import 'package:weather/src/api/open_weather_api.dart';
import 'package:weather/src/models/location.dart';
import 'package:weather/src/models/weather.dart';
import 'package:weather/src/settings/settings_controller.dart';
import 'package:weather/src/widgets/app_bar.dart';
import 'package:weather/src/widgets/forcast_view_daily.dart';
import 'package:weather/src/widgets/forcast_views_hourly.dart';
import 'package:weather/src/widgets/weatherBox.dart';
import 'package:weather/src/widgets/weatherDetailsBox.dart';

class HomePage extends StatefulWidget {
  SettingsController controller;
  List<Location> locations;
  HomePage({Key? key, required this.controller, required this.locations})
      : super(key: key);
  int selectedIndex = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  // List<Location> locations = [
  //   Location(
  //       city: "Sulaymaniyah",
  //       country: "Iraq",
  //       lat: "35.5636634",
  //       lon: "45.4695083")
  // ];

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
      body: SizedBox.expand(
        child: weatherPage(),
      ),
    );
  }

  Widget weatherPage() {
    return FutureBuilder(
      future: getCurrentWeather(widget.locations[0]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CityDropDown(locations),
              createAppBar(widget.controller, widget.locations,
                  widget.locations[0], context),
              weatherBox(snapshot.data as Weather),
              weatherDetailsBox(snapshot.data as Weather),
              forcastViewsHourly(widget.locations[0]),
              const Divider(),
              forcastViewsDaily(widget.locations[0]),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }
}
