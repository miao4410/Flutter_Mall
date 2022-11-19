import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CodeFunPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CodeFunState();
  }
}

class CodeFunState extends State<CodeFunPage> {
  ///声明变量
  late Timer _timer;
  String dateStr = "";
  String weekStr = "";
  String timeStr = "";

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      ///自增
      dateStr = getDate();
      weekStr = getWeek();
      timeStr = getTime();
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return new Scaffold(
        body: Container(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/codeFun/codeFunny.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: size.height / 3 - 10,
              left: size.width / 3 - 20,
              child: Column(
                children: [
                  Text(
                    "$dateStr" + "(" + "$weekStr" + ")",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color.fromARGB(255, 23, 22, 22)),
                  ),
                  Text("$timeStr",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: Color.fromARGB(255, 23, 22, 22)))
                ],
              )),
          Positioned(
              top: size.height / 1.5 - 2,
              left: size.width / 3 + 9,
              child: Text("$dateStr" + " " + "$timeStr",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color.fromARGB(255, 82, 118, 229)))),
          Positioned(
              top: size.height / 1.5 + 27,
              left: size.width / 3 + 10,
              child: Text("大学城",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color.fromARGB(255, 82, 118, 229))))
        ],
      ),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
    ));
  }
}

String getDate() {
  DateTime now = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  return dateFormat.format(now).toString();
}

String getWeek() {
  return DateFormat('EEE', "zh_CN").format(DateTime.now());
}

String getTime() {
  DateTime now = DateTime.now();
  DateFormat dateFormat = DateFormat("HH:mm:ss");
  return dateFormat.format(now).toString();
}
