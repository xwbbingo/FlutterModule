import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:start_app/demo/flutter_architecture/commonui/common_style.dart';
import 'package:start_app/demo/flutter_architecture/util/image_util.dart';

class PhotoViewPage extends StatelessWidget {
  final String title;
  final String url;
  final defaultImg;

  const PhotoViewPage({Key key, this.title, this.url, this.defaultImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: YZStyle.normalTextWhite,
        ),
      ),
      body: Container(
        color: Colors.black,
        child: PhotoView(
          imageProvider: NetworkImage(url),
          loadingBuilder: (context, event) {
            return Container(
              child: Stack(
                children: [
                  Center(
                    child: ImageUtil.getImage(defaultImg, 180, 180),
                  ),
                  Center(
                    child: SpinKitCircle(
                      color: Colors.white30,
                      size: 25,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
