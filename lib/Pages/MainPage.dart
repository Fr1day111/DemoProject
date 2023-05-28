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
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<dynamic>>(
                future: MongoDatabase.fetchPhotos(),
                builder: (context,snapshot){
                  if (snapshot.connectionState==ConnectionState.waiting) {
                    return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        )
                    );
                  }
                  else {
                    return ShowPhotos(snapshot.data);
                  }
                }),
            Container(
              width: logicalWidth,
              height: logicalHeight,
            )
          ],
        ),
      ),
    );
  }

Widget ShowPhotos(List? data) {
  return  SafeArea(
          child: data!.isEmpty?const Text('Nodata'):SingleChildScrollView(
            child: Container(
             // margin: EdgeInsets.symmetric(horizontal: 20),
              //width: logicalWidth,
              //height: logicalHeight*0.3,
              child: CarouselSlider.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index,realIndex) {
                    final document = data![index];
                    return buildImage(document);
                  },
                  options: CarouselOptions(height: logicalHeight * 0.35,autoPlay: true,aspectRatio: 3/2)),
            ),
          ));


}
  Widget buildImage(document) {
    final imageBytes = document['data'].cast<int>();
    final byteData = Uint8List.fromList(imageBytes).buffer.asByteData();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: logicalWidth*0.01),
      //color: Colors.amberAccent,
      //width: logicalWidth,
     // decoration: BoxDecoration(
       // image: DecorationImage(
         //   image: Image.memory(byteData), fit: BoxFit.cover),
      //),
      child: Image.memory(byteData.buffer.asUint8List(),fit: BoxFit.cover,),
    );
  }
}

