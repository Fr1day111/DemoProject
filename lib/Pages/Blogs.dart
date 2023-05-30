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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context, index) {
            final document = data![index];
            return ListTile(
              title: Center(child: Text(document['Title'],style: TextStyle(fontSize: logicalWidth*0.05),)),
              subtitle: Column(
                children: [
                  Text(document['Detail']),
                  Container(
                    height: logicalHeight*0.3,
                    width: double.infinity,
                    //color: Colors.black,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black),
                  ),
                  Divider(thickness: 2,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

