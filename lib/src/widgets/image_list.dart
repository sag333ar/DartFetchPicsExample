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
      child: Column(
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
      ),
    );
  }

}
