import 'package:flutter/material.dart';
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
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
      MongoDatabase.add(title,content);

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
