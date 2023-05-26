import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'Info.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, index,realIndex) {
                    return buildImage(index);
                  },
                  options: CarouselOptions(height: logicalHeight * 0.3,autoPlay: true)),
              Text("Bottom"),
              Container(
                width: logicalWidth,
                height: 20,
                color: Colors.blue,
              )
            ],
          ),
        ));
  }
  Widget buildImage(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      color: Colors.amberAccent,
      width: logicalWidth,
    );
  }
}
