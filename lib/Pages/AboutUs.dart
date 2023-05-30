import 'dart:math';

import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
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
      margin: EdgeInsets.symmetric(horizontal: logicalWidth * 0.01),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Dailekhi Samaj Sewa',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(
              height: logicalHeight * 0.01,
            ),
            Text(
              String.fromCharCodes(
                  List.generate(3000, (index) => Random().nextInt(33) + 89)),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: logicalHeight * 0.03,
            ),
            Container(
              width: double.infinity,
              height: logicalHeight * 0.4,
              color: Colors.black,
            ),
            SizedBox(
              height: logicalHeight * 0.05,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: logicalWidth * 0.01),
              color: Colors.grey,
              width: double.infinity,
              child: Column(
                children: [
                  const Text(
                    'Objectives',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  Text(
                    String.fromCharCodes(List.generate(
                        3000, (index) => Random().nextInt(33) + 89)),
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
