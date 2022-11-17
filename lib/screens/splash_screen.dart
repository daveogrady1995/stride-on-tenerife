import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masterPiece/services/firebase_service.dart';
import 'package:masterPiece/screens/register.dart';
import 'home_navigation_screen.dart';
import 'welcome_screen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> futureTenerifeStartDate;

  @override
  void initState() {
    super.initState();
    futureTenerifeStartDate = getTenerifeStartDate();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: futureTenerifeStartDate,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: AnimatedSplashScreen(
              splash: Image.asset(
                'assets/images/logo.png',
                scale: 2.0,
              ),
              nextScreen: _getStartupScreen(snapshot.data),
              splashTransition: SplashTransition.rotationTransition,
              backgroundColor: Colors.orange[700],
            ),
          );
        });
  }

  Widget _getStartupScreen(int _startDateMillis) {
    var userLoggedIn = isUserLoggedIn();
    if (userLoggedIn) {
      if (_startDateMillis != null) {
        return HomeNavigationScreen();
      } else {
        return WelcomeScreen();
      }
    } else {
      return RegisterPage();
    }
  }

  Future<int> getTenerifeStartDate() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('tenerife_date_start');
  }
}
