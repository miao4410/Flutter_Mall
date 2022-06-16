import 'package:flutter/material.dart';
import 'package:mall/domain/GlobalValue.dart';

import 'AwardWidget.dart';

Widget personInfo() {
  return Container(
    margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 192,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/person/shop_mine_bg.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 53,
          right: -15,
          child: MaterialButton(
              minWidth: 28,
              color: Color(0xFFF8C034),
              child: Text(
                "我的会员",
                style:
                TextStyle(fontSize: 12, color: Color(0xFF443E3F)),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(100)))),
        ),
        Positioned(
            top: 53,
            left: 16,
            child: Text(
              "暂未实名认证" ,
              style: TextStyle(fontSize: 18, color: Colors.white),
            )),
        Positioned(
            top: 83,
            left: 16,
            child: Text(
              "ID：" + "338607",
              style: TextStyle(fontSize: 12, color: Colors.white),
            )),
        Positioned(
            top: 103,
            left: 16,
            child: Text(
              GlobalValue.username,
              style: TextStyle(fontSize: 12, color: Colors.white),
            )),
        awardWidget(),
      ],
    ),
  );
}