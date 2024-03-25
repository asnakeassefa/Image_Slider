import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  final List<File> images;
  final int sec;
  const SliderPage({super.key, required this.images, required this.sec});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('SliderPage'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).height * .9,
        color: Color.fromARGB(255, 236, 243, 248),
        child: ListView(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.sizeOf(context).height * 0.88,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: widget.sec),
              ),
              items: widget.images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.file(i, fit: BoxFit.fitHeight),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
