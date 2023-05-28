import 'package:flutter/material.dart';
import 'package:project1/Pages/Info.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  //final List<dynamic> data=MongoDatabase.fetchData() as List;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: MongoDatabase.fetchData(),
        builder: (context,snapshot){
        if (snapshot.connectionState==ConnectionState.waiting) {
          return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              )
          );
        }
        else {
          return DataScreen(snapshot.data);
        }
        });
  }
}

class DataScreen extends StatelessWidget {
  final List<dynamic>? data;

  DataScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: data!.length,
        itemBuilder: (context, index) {
          final document = data![index];
          return ListTile(
            title: Text(document['Title']),
            subtitle: Text(document['Detail']),
          );
        },
      ),
    );
  }
}

