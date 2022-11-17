import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../items.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<Widget> slides = items
      .map((item) => Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.fitWidth,
                  width: 220.0,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: <Widget>[
                    Text(item['header'],
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w300,
                            color: Color(0XFF3F3D56),
                            height: 2.0)),
                    Text(
                      item['description'],
                      style: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1.2,
                          fontSize: 16.0,
                          height: 1.3),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              item["isTenerifeDatePicker"] == true
                  ? TenerifeDatePicker()
                  : Container()

              //TenerifeDatePicker()
            ],
          )))
      .toList();
  List<Widget> indicator() => List<Widget>.generate(
      slides.length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? Color(0XFF256075)
                    : Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));

  double currentPage = 0.0;
  final int lastPage = 1;
  final int firstPage = 0;
  PageController _pageViewController;

  //final LocalStorage storage = new LocalStorage('user_preferences');

  // keep track of tenerife date time picker widget
  static DateTime tenerifeDatePicked;

  @override
  void initState() {
    super.initState();

    _pageViewController = new PageController(
        initialPage: 0, keepPage: false, viewportFraction: 1.0);
  }

  Future<bool> setTenerifeStartDate(DateTime startDate) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setInt(
        "tenerife_date_start", startDate.millisecondsSinceEpoch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageViewController,
              itemCount: slides.length,
              itemBuilder: (BuildContext context, int index) {
                _pageViewController.addListener(() {
                  setState(() {
                    currentPage = _pageViewController.page;
                  });
                });
                return slides[index];
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, right: 10.0),
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(fontSize: 15)),
                      onPressed: () {
                        if (currentPage.round() == lastPage) {
                          // make sure a date has been chosen
                          if (tenerifeDatePicked != null) {
                            setTenerifeStartDate(tenerifeDatePicked).then(
                                (value) => Navigator.pushReplacementNamed(
                                    context, '/'));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please select a departure date",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          // Navigator.pushReplacementNamed(
                          //     context, '/splash-screen');
                        } else {
                          setState(() {
                            _pageViewController
                                .jumpToPage(currentPage.round() + 1);
                          });
                        }
                      },
                      child: Text(
                        currentPage.round() == lastPage ? "FINISH" : "NEXT",
                      ),
                    )
                  ]),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              textStyle: TextStyle(fontSize: 15)),
                          onPressed: () {
                            if (currentPage.round() == lastPage) {
                              setState(() {
                                _pageViewController
                                    .jumpToPage(currentPage.round() - 1);
                              });
                            }
                          },
                          child: Text(
                            currentPage.round() == firstPage ? "" : "PREVIOUS",
                          ),
                        )
                      ]),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 70.0),
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: indicator(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class TenerifeDatePicker extends StatefulWidget {
  @override
  _TenerifeDatePickerState createState() => _TenerifeDatePickerState();
}

class _TenerifeDatePickerState extends State<TenerifeDatePicker> {
// Which holds the selected date
// Defaults to today's date.
  DateTime currentDate;
  DateTime firstDate;
  DateTime lastDate;
  String formattedDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now().add(new Duration(days: 1));
    firstDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
    lastDate =
        DateTime(currentDate.year + 5, currentDate.month, currentDate.day);
    formattedDate = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[
          Text(
            (formattedDate.isNotEmpty) ? formattedDate : "",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context), // Refer step 3
            child: Text(
              'Select departure date',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: currentDate, // Refer step 1
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != currentDate)
      setState(() {
        currentDate = picked;
        formattedDate = DateFormat.yMMMEd().format(currentDate);
        // update welcome screen variable
        _WelcomeScreen.tenerifeDatePicked = currentDate;
      });
  }
}
