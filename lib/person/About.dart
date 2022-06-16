import 'package:flutter/material.dart';
import 'package:mall/component/myAppBarComponent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SAboutPageState();
  }
}

class SAboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBarComponent(context, "关于"),
        body: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(40.w, 64.h, 0, 0),
                child: Text("FlyDong商城",
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: Color(0xFF443E3F),
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(40.w, 8.h, 0, 0),
                  child: Text("Version 1.0.0",
                      style: TextStyle(
                          fontSize: 12.sp, color: Color(0xFFABA4A5)))),
              Container(
                margin: EdgeInsets.fromLTRB(0, 338.h, 0, 0),
                width: 92.w,
                height: 160.h,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: new DecorationImage(
                        image:
                            AssetImage("assets/images/about/reading.png"))),
              ),
              Center(
                child: Text(
                  "Copyright © 科技股份有限公司",
                  style: TextStyle(fontSize: 12.sp, color: Color(0xFFABA4A5)),
                ),
              ),
              Center(
                child: Text(
                  "版权所有",
                  style: TextStyle(fontSize: 12.sp, color: Color(0xFFABA4A5)),
                ),
              ),
              Center(
                  child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: "联系我们：",
                    style:
                        TextStyle(color: Color(0xFF443E3F), fontSize: 12.sp)),
                TextSpan(
                    text: "400-88888888",
                    style:
                        TextStyle(color: Color(0xFF7ACEFA), fontSize: 12.sp)),
              ]))),
            ],
          ),
        ));
  }
}
