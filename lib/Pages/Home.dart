import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:project1/Pages/AboutUs.dart';
import 'package:project1/Pages/BlogPostForm.dart';
import 'package:project1/Pages/Blogs.dart';
import 'package:project1/Pages/ContactUs.dart';
import 'package:project1/Pages/MainPage.dart';
import 'package:project1/Pages/Photos.dart';
import 'Info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _screens = [
    const MainPage(),
    const AboutUs(),
    const Blogs(),
    const Photos(),
    const ContactUs()
  ];
  var _selected = 0;

  void tapfun(int i) {
    setState(() {
      _selected = i;
    });
    if (_scaffoldKey.currentState!.isEndDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
  String getText()
  {
    switch(_selected)
        {
        case 0 : return 'Home';
        case 1 : return 'About Us';
        case 2 : return 'Blogs';
        case 3 : return 'Photos';
      default : return 'Contact Us';

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: logicalHeight * 0.07,
          title:  Center(child: Text(getText(),style: TextStyle(fontWeight: FontWeight.bold),)),
          elevation: 0,
        ),
        endDrawer: SafeArea(
          child: Drawer(
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("Assets/Logos/logo.png",height: logicalHeight*0.3,width: logicalWidth*0.5,),
                  Container(
                    child: Center(
                      child: Text("Dailekhi Sewa Samaj", style: drawer),
                    ),
                  ),
                  SizedBox(height: logicalHeight*0.15,),
                  Container(
                    color: _selected==0?Colors.purple:Colors.transparent,
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: logicalWidth * 0.05),
                            child: const Icon(
                              Icons.home,
                            ),
                          ),
                          Text(
                            "Home",
                            style: drawer,
                          ),
                        ],
                      ),
                      onTap: () {
                        tapfun(0);
                      },
                    ),
                  ),
                  Container(
                    color: _selected==1?Colors.purple:Colors.transparent,
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: logicalWidth * 0.05),
                            child: const ImageIcon(
                                AssetImage("Assets/Logos/AboutUS.png")),
                          ),
                          Text("About Us", style: drawer),
                        ],
                      ),
                      onTap: () {
                        tapfun(1);
                      },
                    ),
                  ),
                  Container(
                    color: _selected==2?Colors.purple:Colors.transparent,
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: logicalWidth * 0.05),
                            child: const ImageIcon(
                                AssetImage("Assets/Logos/blog.png")),
                          ),
                          Text("Blogs", style: drawer),
                        ],
                      ),
                      onTap: () {
                        tapfun(2);
                      },
                    ),
                  ),
                  Container(
                    color: _selected==3?Colors.purple:Colors.transparent,
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: logicalWidth * 0.05),
                            child: const Icon(Icons.photo),
                          ),
                          Text("Photos", style: drawer),
                        ],
                      ),
                      onTap: () {
                        tapfun(3);
                      },
                    ),
                  ),
                  Container(
                    color: _selected==4?Colors.purple:Colors.transparent,
                    child: GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(right: logicalWidth * 0.05),
                            child: const ImageIcon(
                                AssetImage("Assets/Logos/contact-us-icon.png")),
                          ),
                          Text("Contact Us", style: drawer),
                        ],
                      ),
                      onTap: () {
                        tapfun(4);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: _screens[_selected]);
  }
}
