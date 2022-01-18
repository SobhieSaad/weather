import 'package:flutter/material.dart';
import 'package:weather/src/api/open_weather_api.dart';
import 'package:weather/src/models/location.dart';
import 'package:weather/src/models/weather.dart';
import 'package:weather/src/settings/settings_controller.dart';
import 'package:weather/src/widgets/app_bar.dart';
import 'package:weather/src/widgets/cirt_drop_down_selection.dart';
import 'package:weather/src/widgets/current_weather.dart';
import 'package:weather/src/widgets/forcast_view_daily.dart';
import 'package:weather/src/widgets/forcast_views_hourly.dart';
import 'package:weather/src/widgets/weatherBox.dart';
import 'package:weather/src/widgets/weatherDetailsBox.dart';

class HomePage extends StatefulWidget {
  SettingsController controller;
  HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  PageController pageController = PageController();

  WeatherApiClient client = WeatherApiClient();
  List<Location> locations = [
    Location(
        city: "Sulaymaniyah",
        country: "Iraq",
        lat: "35.5636634",
        lon: "45.4695083")
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          children: [
            weatherPage(),
            Container(
              child: const Text("2"),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        mouseCursor: SystemMouseCursors.grab,
        selectedIconTheme:
            const IconThemeData(color: Colors.lightBlueAccent, size: 35),
        selectedItemColor: Colors.lightBlueAccent,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: selectedIndex,
        onTap: onTabTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.wb_sunny_rounded),
            icon: Icon(Icons.wb_sunny_outlined),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.task_alt_rounded),
            icon: Icon(
              Icons.task_alt_outlined,
            ),
            label: 'Tasks',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: 'Chats',
          // ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  Widget weatherPage() {
    return FutureBuilder(
      future: getCurrentWeather(locations[0]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // CityDropDown(locations),
              createAppBar(locations, locations[0], context),
              weatherBox(snapshot.data as Weather),
              weatherDetailsBox(snapshot.data as Weather),
              forcastViewsHourly(locations[0]),
              const Divider(),
              forcastViewsDaily(locations[0]),
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
