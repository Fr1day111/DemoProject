import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:project1/Pages/Info.dart';
import 'MainPage.dart';

class Photos extends StatefulWidget {
  const Photos({Key? key}) : super(key: key);

  @override
  State<Photos> createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    FutureBuilder<List<dynamic>>(
        future: MongoDatabase.fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ));
          } else {
          return ShowGrid(snapshot.data);
          }
        }
    ));
  }
  Widget ShowGrid(List? data) {
    return SafeArea(
        child: data!.isEmpty
            ? const Text('Nodata')
            : SingleChildScrollView(
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 20),
            //width: logicalWidth,
            height: logicalHeight,
            child: GridView.builder(
              gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final document = data![index];
                  return buildImage(document);
                },
                ),
          ),
        ));
  }

  Widget buildImage(document) {
    final imageBytes = document['data'].cast<int>();
    final byteData = Uint8List.fromList(imageBytes).buffer.asByteData();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: logicalWidth * 0.01),
      //color: Colors.amberAccent,
      //width: logicalWidth,
      // decoration: BoxDecoration(
      // image: DecorationImage(
      //   image: Image.memory(byteData), fit: BoxFit.cover),
      //),
      child: Image.memory(
        byteData.buffer.asUint8List(),
        fit: BoxFit.cover,
        width: logicalWidth,
      ),
    );
  }
}
