import 'package:flutter/material.dart';

Widget awardWidget() {
  return Positioned(
      top: 140,
      width: 343,
      height: 90,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: new BoxDecoration(
          border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
          // 边色与边宽度
          color: Colors.white,
          // 底色
          borderRadius: new BorderRadius.circular((20.0)), // 圆角度
          // borderRadius: BorderRadius.circular(50) // 也可控件一边圆角大小
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text(
                    "推广奖励",
                    style: TextStyle(color: Color(0xFFABA4A5), fontSize: 12),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "736.34" + "元",
                    style: TextStyle(
                        color: Color(0xFF443E3F),
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            )),
            Container(
                margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
                child: MaterialButton(
                    minWidth: 74,
                    color: Colors.red,
                    child: Text(
                      "查看",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)))))
          ],
        ),
      ));
}
