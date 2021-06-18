import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class ImageScreen extends StatefulWidget {
  final String? image;
  final String? title;
  const ImageScreen({required this.image , required this.title});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.black,title:Text( widget.title!), ),
      body: Container(child: Center(child:
      PhotoView( maxScale: 2.5,
        imageProvider: NetworkImage(widget.image!),
      ),
      ),
      ),
    );
  }
}
