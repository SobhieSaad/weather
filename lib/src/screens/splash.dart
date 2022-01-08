import 'package:flutter/material.dart';
import 'package:weather/src/home.dart';
import 'package:weather/src/settings/settings_controller.dart';

class SplashScreen extends StatefulWidget {
  final SettingsController settingsController;

  const SplashScreen({Key? key, required this.settingsController})
      : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late final Duration duration;
  @override
  void initState() {
    animationController = AnimationController(duration: duration, vsync: this)
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      HomePage(controller: widget.settingsController)));
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        const Divider(
          height: 240.0,
          color: Colors.white,
        ),
        Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
          width: 170.0,
        ),
        const Divider(
          height: 105.2,
          color: Colors.white,
        ),
      ]),
    );
  }
}
