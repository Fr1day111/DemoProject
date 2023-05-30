import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

var pixelRatio = window.devicePixelRatio;

//Size in physical pixels
var physicalScreenSize = window.physicalSize;
var physicalWidth = physicalScreenSize.width;
var physicalHeight = physicalScreenSize.height;

//Size in logical pixels
var logicalScreenSize = window.physicalSize / pixelRatio;
var logicalWidth = logicalScreenSize.width;
var logicalHeight = logicalScreenSize.height;

TextStyle drawer =TextStyle(
    fontSize: logicalWidth/17,
    fontWeight: FontWeight.bold,
    color: Colors.black
  );

String ConURL='mongodb+srv://admin:admin@cluster0.he7k85g.mongodb.net/Demo';

class MongoDatabase {
  //var db;
  static connect() async {
   var db= await mongo.Db.create(ConURL);
    await db.open().then((value) {
      //print("****************************");
      db.close();
    }).onError((error, stackTrace) {
      print(error);
      print("***********");
    });

    //var collection= db.collection('users');
    //print(await collection.find().toList());
  }
   static add(String t,String d,List? p) async {
     var db= await mongo.Db.create(ConURL);
     await db.open();
     //connect();
    var blogs=db.collection('Feedback');

    await blogs.insertOne({
      'Title' : t,
      'Detail':d,
      'Photos': p
    });
  }
  static Future<List<dynamic>> fetchData() async {
    List<dynamic> data=[];
    var db = await mongo.Db.create(ConURL);
    await db.open();

    final collection = db.collection('Blogs');
    final cursor = collection.find();
    await cursor.forEach((doc) {
      data.add(doc);
    });
  //  print(data);
    //print("************************");
    await db.close();
    return data;
  }
  static Future<List<dynamic>> fetchPhotos() async {
    List<dynamic> data=[];
    var db = await mongo.Db.create(ConURL);
    await db.open();
    final gridFS =mongo.GridFS(db);
    final collection = db.collection('photos');
    final cursor = collection.find();

    await cursor.forEach((doc) {
      data.add(doc);
    });
    //  print(data);
    //print("************************");
    await db.close();
    return data;
  }
  static storePhotoInMongoDB(var photoData) async {
    final db = await mongo.Db.create(ConURL);
    await db.open();

    final photoCollection = db.collection('photos');

    final photo = {
      'data': photoData,
    };

    await photoCollection.insert(photo);

    await db.close();
  }

}
