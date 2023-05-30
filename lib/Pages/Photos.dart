import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
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
            height: logicalHeight,
            child: GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: logicalHeight*0.01,
              ),
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final document = data![index];
                  return GestureDetector(child: buildImage(document),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImage(document: document),
                      ),
                    );
                  },);
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
      child: Image.memory(
        byteData.buffer.asUint8List(),
        fit: BoxFit.cover,
        width: logicalWidth,
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  //final int index;
  var document;

  FullScreenImage({required this.document});


  @override
  Widget build(BuildContext context) {
    final imageBytes = document['data'].cast<int>();
    final byteData = Uint8List
        .fromList(imageBytes)
        .buffer
        .asByteData();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'image_',
            child: Image.memory(
              byteData.buffer.asUint8List(),
              // Replace with your image asset path
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
