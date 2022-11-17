import 'package:flutter/material.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class MyCountdownDemo extends StatefulWidget {
  MyCountdownDemo(this.tenerifeStartDate);
  final Future<int> tenerifeStartDate;

  final String title = 'Countdown Clock';

  @override
  _MyCountdownDemo createState() => _MyCountdownDemo();
}

class _MyCountdownDemo extends State<MyCountdownDemo> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  DateTime _tenerifeDate = DateTime(2021, 06, 03);
  DateTime _myDay = DateTime(2021, 02, 14);
  Duration _dateDifference;
  Duration _duration;

  @override
  void initState() {
    super.initState();

//    var d = _tenerifeDate.difference(datenow);
//
//    var hour1 = DateTime.now().hour;
//    var hour2 = _tenerifeDate.difference(datenow).inHours;
//    var days = datenow.difference(_myDay).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: widget.tenerifeStartDate,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.hasData) {
            var tenerifeStartDate =
                DateTime.fromMillisecondsSinceEpoch(snapshot.data);
            var diffrence = tenerifeStartDate.difference(DateTime.now());
            _duration = Duration(seconds: diffrence.inSeconds);
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //_buildSpace(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: SlideCountdownClock(
                      duration: _duration, // update variable every 1 second
                      slideDirection: SlideDirection.Up,
                      separator: "-",
                      shouldShowDays: true,
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      separatorTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange[800], shape: BoxShape.circle),
                      onDone: () {
//                        _scaffoldKey.currentState.showSnackBar(
//                            SnackBar(content: Text('Clock 1 finished')));
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }

  Widget _buildSpace() {
    return SizedBox(height: 50);
  }
}
