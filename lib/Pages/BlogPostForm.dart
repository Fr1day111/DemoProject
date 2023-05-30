import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project1/Pages/Info.dart';
import 'package:project1/main.dart';

class BlogPostForm extends StatefulWidget {
  const BlogPostForm({super.key});

  @override
  _BlogPostFormState createState() => _BlogPostFormState();
}

class _BlogPostFormState extends State<BlogPostForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles != null){
        imagefiles = pickedfiles;
        setState(() {
        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }


  void _submitForm()  async {
    List<String> pics=[];
    if (_formKey.currentState!.validate()) {
      //var bytes = await imagefiles!.readAsBytes();
      //var photo = Uint8List.fromList(bytes);
      // Perform your blog post submission logic here
      String title = _titleController.text;
      String content = _contentController.text;
      // You can send the data to your API or save it locally

      // Clear the form fields
      _titleController.clear();
      _contentController.clear();

      // Show a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Blog post submitted!')),
      );
      //MongoDatabase.connect();
      print(imagefiles![0].readAsBytes());
      print(imagefiles!.length);
      print("******************************8");
      for(int i=0;i<imagefiles!.length;i++)
        {
          var bytes = await imagefiles![i].readAsBytes();
          print("************************");
          print(i);
          print(base64Encode(bytes));
          //print(Uint8List.fromList(bytes));
          pics.add(base64Encode(bytes));
        }

      MongoDatabase.add(title,content,pics);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
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
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: (){
                      openImages();
                    },
                    child: Text("Open Images")
                ),

                Divider(),
                Text("Picked Files:"),
                Divider(),

                imagefiles != null?Wrap(
                  children: imagefiles!.map((imageone){
                    return Container(
                        child:Card(
                          child: Container(
                            height: 100, width:100,
                            child: Image.file(File(imageone.path)),
                          ),
                        )
                    );
                  }).toList(),
                ):Container(),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
