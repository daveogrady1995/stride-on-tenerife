import 'package:flutter/material.dart';

class ItineraryScreen extends StatefulWidget {
  @override
  _ItineraryScreenState createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.blue],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Itenerary',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            Container()
          ],
        ),
      ),
      body: Center(child: Text("Coming soon!", style: TextStyle(fontSize: 20))),
    );
  }
}

//class MyTimeline extends StatefulWidget {
//  MyTimeline({Key key}) : super(key: key);
//
//  @override
//  _MyTimelineState createState() => _MyTimelineState();
//}

//class _MyTimelineState extends State<MyTimeline> {
//  @override
//  Widget build(BuildContext context) {
//    return Timeline.tileBuilder(
//      builder: TimelineTileBuilder.fromStyle(
//        contentsAlign: ContentsAlign.alternating,
//        contentsBuilder: (context, index) => Padding(
//          padding: const EdgeInsets.all(24.0),
//          child: Text('Day $index'),
//        ),
//        itemCount: 10,
//      ),
//    );
//  }
//}
//
//class BubbleTimeLine extends StatefulWidget {
//  BubbleTimeLine({Key key}) : super(key: key);
//
//  @override
//  _BubbleTimeLineState createState() => _BubbleTimeLineState();
//}
//
//class _BubbleTimeLineState extends State<BubbleTimeLine> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        child: BubbleTimeline(
//      bubbleDiameter: 120,
//      // List of Timeline Bubble Items
//      items: [
//        TimelineItem(
//          title: 'Dublin Airport',
//          subtitle: 'Travel To Dublin Airport',
//          child: Icon(
//            Icons.directions_car,
//            color: Colors.white,
//          ),
//          bubbleColor: Colors.orange[800],
//        ),
//        TimelineItem(
//          title: 'TFS',
//          subtitle: 'On Route To Tenerife!',
//          child: Icon(
//            Icons.airline_seat_recline_normal_sharp,
//            color: Colors.white,
//          ),
//          bubbleColor: Colors.orange[800],
//        ),
//        TimelineItem(
//          title: 'Taxi',
//          subtitle: 'Getting Taxi to Guaymarina!',
//          child: Icon(
//            Icons.directions_bus,
//            color: Colors.white,
//          ),
//          bubbleColor: Colors.orange[800],
//        ),
//      ],
//      stripColor: Colors.blue[600],
//      scaffoldColor: Colors.white,
//    ));
//  }
//}
