import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  ///声明变量
  late Timer _timer;

  ///记录当前的时间
  int currentTime = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: [
          Container(
            height: double.maxFinite,
            child: Image.asset(
              "assets/images/login/splash.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            right: 20.w,
            bottom: 20.h,
            width: 74.w,
            child: OutlinedButton(
              child: new Text(
                "跳过" + "$currentTime",
                textAlign: TextAlign.center,
                style: new TextStyle(color: Colors.white),
              ),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 0.5, color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100.r)),
                  )),
              // StadiumBorder椭圆的形状
              onPressed: () {
                _timer.cancel();
                registerPage();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      ///自增
      currentTime--;

      // 到5秒后停止
      if (currentTime == 0) {
        _timer.cancel();
        registerPage();
      }
      setState(() {});
    });

    // 倒计时
    // var _duration = new Duration(seconds: 3);
    // new Future.delayed(_duration, registerPage);
  }

  @override
  void dispose() {
    ///取消计时器
    _timer.cancel();
    super.dispose();
  }

  void registerPage() {
    Navigator.pushNamed(context, "google_register_page");
  }
}
