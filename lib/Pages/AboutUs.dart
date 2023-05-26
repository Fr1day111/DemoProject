import 'package:flutter/material.dart';
import 'Info.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: logicalWidth,
        height: logicalHeight,
        color: Colors.deepOrange,

      )
    );
  }
}
