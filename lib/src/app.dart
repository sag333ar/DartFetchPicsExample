import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'dart:convert';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {

  int count = 0;
  List<ImageModel> imageModels = [];

  void fetchImage() async {
    count++;
    final result = await get('https://jsonplaceholder.typicode.com/photos/$count');
    final model = new ImageModel.fromJson(json.decode(result.body));

    setState(() {
      imageModels.add(model);
    });

  }

  @override
  Widget build(context) {
    return new MaterialApp(
      home: Scaffold(
          body: ImageList(imageModels),
          appBar: AppBar(
            title: Text("Yo ! Let's see some images."),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: fetchImage,
            child: Icon(Icons.add),
          )),
    );
  }
}
