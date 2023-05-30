import 'dart:typed_data';

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
    return SafeArea(
      child: SizedBox(
        height: logicalHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: logicalHeight * 0.4,
                child: FutureBuilder<List<dynamic>>(
                    future: MongoDatabase.fetchPhotos(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Scaffold(
                            body: Center(
                          child: CircularProgressIndicator(),
                        ));
                      } else if (snapshot.hasData) {
                        return ShowPhotos(snapshot.data);
                      } else {
                        return const Center(child: Text("No DATA"));
                      }
                    }),
              ),
              Container(
                width: logicalWidth,
                height: logicalHeight,
                color: Colors.amberAccent,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ShowPhotos(List? data) {
    return SafeArea(
        child: data!.isEmpty
            ? const Text('No data')
            : SingleChildScrollView(
                child: CarouselSlider.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index, realIndex) {
                      final document = data![index];
                      return buildImage(document);
                    },
                    options: CarouselOptions(
                        height: logicalHeight * 0.35,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        //aspectRatio: 6 / 2,
                        autoPlayCurve: Curves.fastOutSlowIn)),
              ));
  }

  Widget buildImage(document) {
    final imageBytes = document['data'].cast<int>();
    final byteData = Uint8List.fromList(imageBytes).buffer.asByteData();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: logicalWidth * 0.01),
      child: Image.memory(
        byteData.buffer.asUint8List(),
        fit: BoxFit.cover,
        width: logicalWidth,
      ),
    );
  }
}
