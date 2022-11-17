import 'package:flutter/material.dart';

class TweetImagePreviewScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final String photoUrl;

  // In the constructor, require a Todo.
  TweetImagePreviewScreen({Key key, @required this.photoUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StrideOn: Tenerife"),
      ),
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: Image.network(
            photoUrl,
          ),
        ),
      ),
    );
  }
}
