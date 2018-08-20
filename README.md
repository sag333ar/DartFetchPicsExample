# pics


![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)

![Demo Output for Android](https://github.com/sag333ar/DartFetchPicsExample/blob/master/images/Screenshot_1534729780.png?raw=true)
![Demo Output for iOS](https://github.com/sag333ar/DartFetchPicsExample/blob/master/images/ScreenShot_2018-08-20_7.33.56.png?raw=true)

### Main file

File Location - `pics/lib/main.dart`

```dart
// It imports material from flutter package
import 'package:flutter/material.dart';

// It imports app class from src folder. This file is added below.
import 'src/app.dart';

// Main function - from where app launches.
void main() {
  // in order to launch app use runApp function.
  // it accepts `MaterialApp` as an argument.
  runApp(new App());
}
```

Here `runApp` function takes an instance of `MaterialApp` as an argument.
We've created an instance of `App` class, which returns `MaterialApp` widget.

---

### `App` class in `app.dart` file.

Following is `app.dart` file which has `App` class.
File Location - `pics/lib/src/main.dart`

```dart
// It imports material from flutter package
import 'package:flutter/material.dart';

// It only imports get function from http from http-package.
// It is used here to make GET calls.
import 'package:http/http.dart' show get;

// It imports model class from models folder. This file is added below.
import 'models/image_model.dart';

// It imports dart standard library. It is used here for JSON to object conversion.
import 'dart:convert';

// It imports `ImageList` class from widgets folder.
// This is used here to create custom widget.
import 'widgets/image_list.dart';

// Following `App` class is a `StatefulWidget` provider.
// It generates `StatefulWidget` with instance of `AppState` class which is defined below.
class App extends StatefulWidget {

  // required to override following method
  @override
  createState() {
    // It should return a state-based-widget.
    return AppState();
  }
}
```

### `AppState` class in `app.dart` file.

File Location - `pics/lib/src/main.dart`

```dart
// `AppState class basically creates a widget as a state.
// It provides widget to `App` class.
// It holds variable which changes, for example, 
class AppState extends State<App> {

  // On click, counter will be increased
  int count = 0;
  // A list of Custom Models for images which we will receive from server
  List<ImageModel> imageModels = [];

  // An async function which will fetch image data from server with get request.
  void fetchImage() async {
    // counter is increased by 1.
    count++;
    // we're trying to get image model using count
    // e.g. https://jsonplaceholder.typicode.com/photos/1
    final result = await get('https://jsonplaceholder.typicode.com/photos/$count');
    // Creating new instance of `ImageModel` from JSON response
    final model = new ImageModel.fromJson(json.decode(result.body));

    // With following function, we're asking to UI to reload with new Data.
    setState(() {
      // Update image models List.
      imageModels.add(model);
    });

  }

  // Following method builds the actual User Interface.
  @override
  Widget build(context) {
    // We're creatng an instance of `MaterialApp` widget
    return new MaterialApp(
      // For home, we're creating & supplying `Scaffold` type widget
      home: Scaffold(
          // For body, we're creating `ImageList` type widget. 
          body: ImageList(imageModels),
          // For appBar, we're creating `AppBar` type widget.
          appBar: AppBar(
            title: Text("Yo ! Let's see some images."),
          ),
          // we're creating floatingActionButton here.
          floatingActionButton: FloatingActionButton(
            // onPressed, we're invoking `fetchImage` async function.
            onPressed: fetchImage,
            // with a custom add icon.
            child: Icon(Icons.add),
          ),
        ),
    );
  }

}
```

---

### Custom Widget - Image List

File Location - `pics/lib/src/widgets/image_list.dart`

```dart
import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> imageModels;

  ImageList(this.imageModels);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imageModels.length,
      itemBuilder: (context, int index) {
        return buildImageContainer(imageModels[index]);
      },
    );
  }

  Widget buildImageContainer(ImageModel model) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey
          ),
      ),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(20.0),
      child: buildColumnChild(model)
    );
  }

  Widget buildColumnChild(ImageModel model) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: 10.0,
          ),
          child: Image.network(model.url),
        ),
        Text(
          model.title,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

}

```

---

### Data Model - Image

File Location - `pics/lib/src/models/image_model.dart`

```dart

class ImageModel {

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  ImageModel(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    albumId = parsedJson['albumId'];
    id = parsedJson['id'];
    title = parsedJson['title'];
    url = parsedJson['url'];
    thumbnailUrl = parsedJson['thumbnailUrl'];
  }

  @override
  String toString() {
    return "{\n\talbumId: $albumId\n\tid: $id\n\ttitle: $title\n\turl: $url\n\tthumbnailUrl: $thumbnailUrl\n}";
  }

}
```
