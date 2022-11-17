import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdsPage extends StatefulWidget {
  @override
  _NativeAdsPageState createState() => _NativeAdsPageState();
}

class _NativeAdsPageState extends State<NativeAdsPage> {
  NativeAd _ad;
  bool _isAdLoaded = false;
  static final _kAdIndex = 4;
  List<Object> itemList = [];

  @override
  void initState() {
    super.initState();
    _ad = NativeAd(
        adUnitId: 'ca-app-pub-6011637093637517/7406867752',
        factoryId: "listTweetAds",
        listener: NativeAdListener(onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad load failed ' + error.message);
        }),
        request: AdRequest());

    _ad.load();

    for (int i = 1; i <= 20; i++) {
      itemList.add('Row $i');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: itemList.length + (_isAdLoaded ? 1 : 0),
          itemBuilder: (context, index) {
            if (_isAdLoaded && index == _kAdIndex) {
              return Container(
                child: AdWidget(ad: _ad),
                height: 72,
                alignment: Alignment.center,
              );
            } else {
              final item = itemList[_getDestinationItemIndex(index)] as String;
              return ListTile(
                leading: Image.network(
                    "https://i.picsum.photos/id/807/200/200.jpg?hmac=Y8gayvNItiQYxP_Pd-2un9GH09XuyJdIZOQPw6K9QsI"),
                title: Text(
                  item,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Test Description"),
              );
            }
          }),
    );
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }

    return rawIndex;
  }
}
