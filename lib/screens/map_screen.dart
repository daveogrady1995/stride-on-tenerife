import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.076590, -16.731925),
    zoom: 15.0,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(28.085160, -16.734137),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
              'Map',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            Container()
          ],
        ),
      ),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        // Container(
        //     alignment: Alignment.topRight,
        //     padding: EdgeInsets.all(8.0),
        //     child: ElevatedButton.icon(
        //       onPressed: () {
        //         _goToTheLake();
        //       },
        //       icon: Icon(Icons.hotel, size: 18),
        //       style: ElevatedButton.styleFrom(
        //           primary: Colors.orange[700], // background
        //           onPrimary: Colors.white, // foreground
        //           shape: RoundedRectangleBorder(
        //               borderRadius: new BorderRadius.circular(30.0))),
        //       label: Text("Hotel"),
        //     )),
      ]),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
