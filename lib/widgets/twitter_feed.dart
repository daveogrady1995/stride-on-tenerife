import 'package:flutter/material.dart';
import 'package:masterPiece/models/Tweet.dart';
import 'package:masterPiece/models/TwitterUser.dart';
import 'package:masterPiece/screens/home_screen.dart';
import 'package:masterPiece/screens/tweet_image_preview_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class MyTwitterFeed extends StatefulWidget {
  MyTwitterFeed(this.futureTweets);
  final Future<List<Tweet>> futureTweets;

  @override
  _MyTwitterFeedState createState() => _MyTwitterFeedState();
}

class _MyTwitterFeedState extends State<MyTwitterFeed> {
  BannerAd _ad;
  bool _isAdLoaded = false;
  static var _kAdIndex = 4;
  List<Object> itemList = [];

  @override
  void initState() {
    super.initState();

    _ad = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-6011637093637517/5614741105'
          : 'ca-app-pub-6011637093637517/3444653586',
      size: AdSize.leaderboard,
      request: AdRequest(),
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          _isAdLoaded = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
        print('Ad load failed ' + error.message);
      }),
    );

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: Future.wait([widget.futureTweets]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                var tweets = snapshot.data[0];
                return Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  thickness: 8,
                                  color: Colors.grey[200],
                                ),
                            itemCount: tweets.length + (_isAdLoaded ? 1 : 0),
                            // Provide a builder function. This is where the magic happens.
                            // Convert each item into a widget based on the type of item it is.
                            itemBuilder: (context, index) {
                              Tweet tweet =
                                  tweets[_getDestinationItemIndex(index)];

                              if (_isAdLoaded && index == _kAdIndex) {
                                return Container(
                                  child: AdWidget(ad: _ad),
                                  height: 72,
                                  alignment: Alignment.center,
                                );
                              } else {
                                return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _profileImage(),
                                          Expanded(
                                              flex: 10,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    tweetUsername(),
                                                    SizedBox(width: 2),
                                                    tweetUserHandle(),
                                                  ]),
                                                  tweetText(tweet),
                                                  tweet.photoUrl.isNotEmpty
                                                      ? tweetPhoto(
                                                          tweet, context)
                                                      : Container()
                                                ],
                                              ))
                                        ]));
                              }
                            })));
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            }));
  }

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }

    return rawIndex;
  }

  Widget _profileImage() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 50.0,
      height: 50.0,
      decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
        image: new DecorationImage(
          image: new ExactAssetImage('assets/images/visittenerife.png'),
          //image: new NetworkImage(user.photoUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
        border: new Border.all(
          color: Colors.grey[200],
          width: 1.5,
        ),
      ),
    );
  }

  Widget tweetUsername() {
    return Text("Visit Tenerife",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold));
  }

  Widget tweetUserHandle() {
    return Text("@visit_tenerife", style: TextStyle(fontSize: 15));
  }

  Widget tweetText(Tweet tweet) {
    return Text(tweet.tweetText, style: TextStyle(fontSize: 15));
  }

  Widget tweetPhoto(Tweet tweet, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: GestureDetector(
              child: new Container(
                  width: 300,
                  height: 200,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                    fit: BoxFit.cover,
                    alignment: FractionalOffset.topCenter,
                    image: NetworkImage(tweet.photoUrl),
                  ))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TweetImagePreviewScreen(photoUrl: tweet.photoUrl),
                  ),
                );
              })),
    );
    // return Image.network(
    //     'https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500');
  }
}
