import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project1/Pages/Info.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Future picUploadImage() async {
    print("Called*******");
    PermissionStatus status = await Permission.storage.request();
    if (status.isDenied) {
      print("Denied***");
      print("Denied***");
      //Permission.accessMediaLocation.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
    var image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);
    //var file = File('path_to_your_photo.jpg');
    var bytes = await image!.readAsBytes();
    var photo = Uint8List.fromList(bytes);
    MongoDatabase.storePhotoInMongoDB(photo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                TextEditingController _titleController =
                    TextEditingController();
                TextEditingController _contentController =
                    TextEditingController();
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Feedback'),
                          content: Column(
                            children: [
                              TextFormField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a title';
                                  }
                                  return null;
                                },
                              ),
                              //SizedBox(height: 16.0),
                              TextFormField(
                                controller: _contentController,
                                decoration: const InputDecoration(
                                  labelText: 'Content',
                                ),
                                maxLines: 10,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some content';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                               // MongoDatabase.add(_titleController.text,
                                 //   _contentController.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Feedback submitted!')));
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              },
              child: Text("FeedBack")),
          ElevatedButton(
              onPressed: () {
                picUploadImage();
              },
              child: Text('Add Photos'))
        ],
      )),
    );
  }
}
