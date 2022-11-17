import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:masterPiece/screens/login.dart';
import 'package:masterPiece/services/TwitterAPIService.dart';
import 'package:masterPiece/services/firebase_service.dart';
import 'package:masterPiece/screens/weather.dart';
import 'package:masterPiece/widgets/image_carousel.dart';
import 'package:masterPiece/widgets/tenerife_countdown.dart';
import 'package:masterPiece/widgets/twitter_feed.dart';
import 'package:masterPiece/screens/native_ads_page.dart';
import '../models/Tweet.dart';
import '../models/TwitterUser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'welcome_screen.dart';

var datenow = DateTime.now();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BannerAd myBanner = BannerAd(
    adUnitId: Platform.isAndroid
        ? 'ca-app-pub-6011637093637517/5614741105'
        : 'ca-app-pub-6011637093637517/3444653586',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Tweet>> futureTweets;
  Future<int> futureTenerifeStartDate;

  @override
  void initState() {
    super.initState();
    myBanner.load();

    if (isUserLoggedIn())
      futureTweets = TwitterAPIService().getTwitterNewsFeed();
    //futureTwitterUser = TwitterAPIService().getUserInfo();
    futureTenerifeStartDate = getTenerifeStartDate();
  }

  Future<int> getTenerifeStartDate() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('tenerife_date_start');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: 35,
              ),
              Text(
                '  Stride On',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.calendar_today),
              iconSize: 28,
              tooltip: 'Show Calendar',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.wb_sunny),
              iconSize: 28,
              tooltip: 'Show Weather',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 28,
              tooltip: 'Log Out',
              onPressed: () async {
                await signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            )
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CarouselDemo(),
              MyCountdownDemo(futureTenerifeStartDate),
              MyTwitterFeed(futureTweets),
            ]));
  }
}
