import 'dart:math';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
                margin: EdgeInsets.symmetric(horizontal: logicalWidth * 0.05),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: logicalHeight * 0.04,
                      color: Color(0xFFd3d8de),
                      child: Text(
                        'Introduction',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: logicalHeight * 0.03),
                      ),
                    ),
                    Text(
                      String.fromCharCodes(List.generate(
                          1000, (index) => Random().nextInt(33) + 89)),
                      style: const TextStyle(
                          fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFd3d8de),
                  ),
                  width: double.infinity,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: logicalWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: logicalHeight * 0.05,
                        ),
                        Text(
                          'HIGHLIGHTS:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: logicalWidth * 0.07),
                        ),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: logicalHeight * 0.25,
                                width: logicalWidth * 0.4,
                                child: LottieBuilder.asset(
                                    'Assets/Logos/mission.json'),
                              ),
                              Text(
                                'MISSIONS',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: logicalWidth * 0.05),
                              )
                            ],
                          ),
                        ),
                        Text(
                          String.fromCharCodes(List.generate(
                              500, (index) => Random().nextInt(33) + 89)),
                          style: const TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: logicalHeight * 0.25,
                                width: logicalWidth * 0.4,
                                child: LottieBuilder.asset(
                                    'Assets/Logos/vision.json'),
                              ),
                              Text(
                                'Vision',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: logicalWidth * 0.05),
                              )
                            ],
                          ),
                        ),
                        Text(
                          String.fromCharCodes(List.generate(
                              500, (index) => Random().nextInt(33) + 89)),
                          style: const TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: logicalHeight * 0.25,
                                width: logicalWidth * 0.4,
                                child: LottieBuilder.asset(
                                    'Assets/Logos/normsandvalues.json'),
                              ),
                              Text(
                                'Norms And Values',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: logicalWidth * 0.05),
                              )
                            ],
                          ),
                        ),
                        Text(
                          String.fromCharCodes(List.generate(
                              500, (index) => Random().nextInt(33) + 89)),
                          style: const TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: logicalHeight * 0.25,
                                width: logicalWidth * 0.4,
                                child: LottieBuilder.asset(
                                    'Assets/Logos/goals.json',reverse: true,),
                              ),
                              Text(
                                'GOALS',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: logicalWidth * 0.05),
                              )
                            ],
                          ),
                        ),
                        Text(
                          String.fromCharCodes(List.generate(
                              500, (index) => Random().nextInt(33) + 89)),
                          style: const TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
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
