import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

// ignore: must_be_immutable
class ViewImage extends StatefulWidget {
  String url;
  ViewImage({this.url});
  @override
  _ViewImageState createState() => _ViewImageState(
    url,
  );
}

class _ViewImageState extends State<ViewImage> {
  String url;
  _ViewImageState(
      this.url,
      );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Container(
      height: size.height,
      width: size.width,
      child: PhotoView(
        imageProvider: NetworkImage(url),

        loadingBuilder: (context, event) => Center(
          child: Column(
            children: [
              Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                ),
              ),
              SizedBox(height: 20,),

              Text('Loading...',
                style: TextStyle(
                  color: Colors.white,
                ),),
            ],
          ),
        ),

      ),

    );
  }
}
