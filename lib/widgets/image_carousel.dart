import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselDemo extends StatelessWidget {
  final List<Widget> _images = [
    new Image.asset('assets/images/turtlesnorkling.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/Tenerife.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/guaymarina.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/cocktails.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/sunset.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/stargazing.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/hardrock.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/hardrockcafeview.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/poolsea.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/dolphintenerife.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
    new Image.asset('assets/images/coconut.jpg',
        width: 600.0, height: 240.0, fit: BoxFit.cover),
  ];
  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
    CarouselSlider(
      items: _images,
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        aspectRatio: 2.0,
        initialPage: 2,
      ),
    ),
  ]);
}