import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoBrowsePage extends StatefulWidget {
  final List<String>? images;
  final int initIndex;
  const PhotoBrowsePage({
    Key? key,
    this.images,
    this.initIndex = 0,
  }) : super(key: key);

  @override
  _PhotoBrowsePageState createState() => _PhotoBrowsePageState();
}

class _PhotoBrowsePageState extends State<PhotoBrowsePage> {
  PageController? controller;
  int currentIndex = 0;

  /// 测试
  List<String> imagesTest = <String>[
    'https://photo.tuchong.com/14649482/f/601672690.jpg',
    'https://photo.tuchong.com/17325605/f/641585173.jpg',
    'https://photo.tuchong.com/3541468/f/256561232.jpg',
    'https://photo.tuchong.com/16709139/f/278778447.jpg',
    'https://photo.tuchong.com/15195571/f/233361383.jpg',
    'https://photo.tuchong.com/5040418/f/43305517.jpg',
    'https://photo.tuchong.com/3019649/f/302699092.jpg'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.images = images;
    currentIndex = widget.initIndex;
    controller = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // Get.back();
            },
            child: Container(
              color: Colors.transparent,
              child: ExtendedImageGesturePageView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var item = imagesTest[index];
                  Widget image = ExtendedImage.network(
                    item,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.gesture,
                  );
                  image = Container(
                    child: image,
                    padding: EdgeInsets.all(5.0),
                  );
                  if (index == currentIndex) {
                    return Hero(
                      tag: item + index.toString(),
                      child: image,
                    );
                  } else {
                    return image;
                  }
                },
                itemCount: imagesTest.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                // controller: PageController(
                //   initialPage: widget.currentIndex,
                // ),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Positioned(
            //图片index显示
            top: MediaQuery.of(context).padding.top + 15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex + 1}/${imagesTest.length}",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
