import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:mall/util/ToastUtil.dart';

import '../domain/GlobalValue.dart';

class LoginPage extends StatefulWidget {
  LoginPage({required Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _telephoneEditingController =
      new TextEditingController(text: '15510809870');

  TextEditingController _verifyCodeEditingController =
      new TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    //Scaffold是Material中主要的布局组件.
    return new Scaffold(
      // 处理键盘弹框引起的布局
      resizeToAvoidBottomInset: false,
      // Column占整个屏幕的高度
      body: new Column(
        children: [
          //  Logo
          Container(
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
            width: 92.0,
            height: 92.0,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: new DecorationImage(
                    image: AssetImage("assets/images/login/login-icon.png"))),
          ),
          // 登录表单
          Form(
              child: Column(
            children: [
              // 用户名输入框
              Container(
                  margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
                  child: new TextField(
                    controller: _telephoneEditingController,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintText: '请输入手机号',
                      hintStyle:
                          TextStyle(fontSize: 16.sp, color: Color(0xFFBCBCBC)),
                    ),
                  )),
              // 密码输入框
              Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Stack(
                    children: [
                      Container(
                        child: new TextField(
                          controller: _verifyCodeEditingController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20),
                            hintText: '请输入验证码',
                            hintStyle: TextStyle(
                                fontSize: 16.sp, color: Color(0xFFBCBCBC)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 21,
                        top: 10,
                        height: 35,
                        width: 120,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFF9445D)),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.r)),
                              )),
                          child: Text(
                            "获取验证码",
                            style: TextStyle(
                                fontSize: 16.sp, color: Color(0xFFF9445D)),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )),
              // 登录按钮
              Container(
                height: 40.h,
                width: 215.w,
                margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: MaterialButton(
                    minWidth: 20,
                    color: Colors.red,
                    child: Text(
                      "登录",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                    onPressed: () {
                      login(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(100.r)))),
              ),
              // 注册按钮
              Container(
                height: 40.h,
                width: 215.w,
                margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.r))),
                      side: BorderSide(width: 1, color: Color(0xFFF9445D))),
                  child: Text(
                    "注册",
                    style: TextStyle(fontSize: 16.sp, color: Color(0xFFF9445D)),
                  ),
                  onPressed: () {
                    showRegisterDialog(context);
                  },
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  // 登录按钮触发的事件
  login(BuildContext context) {
    String telephone = _telephoneEditingController.text;
    String verifyCode = _verifyCodeEditingController.text;
    HttpUtil.post("/login", {"telephone": telephone, "password": verifyCode},
        (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        HttpUtil.token = result["data"]["token"].toString();
        GlobalValue.nickname = result["data"]["nickname"].toString();
        GlobalValue.username = result["data"]["username"].toString();
        GlobalValue.email = result["data"]["email"].toString();
        GlobalValue.avatar = result["data"]["avatar"].toString();
        GlobalValue.sex = result["data"]["sex"].toString();
        GlobalValue.telephone = result["data"]["telephone"].toString();

        // LoggerUtil.info("token:" + HttpUtil.token);
        Navigator.pushNamed(context, "index_page");
      } else {
        ToastUtil.error(result["msg"]);
      }
    }, (error) {
      ToastUtil.error("服务器连接异常");
    });
  }

  // 注册按钮触发的事件
  showRegisterDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("用户协议及隐私政策"),
            content: RichText(
              text: TextSpan(
                  text: "我们非常重视隐私和个人信息保护，请您先认真阅读《",
                  style: TextStyle(color: Color(0xFF443E3F), fontSize: 14),
                  children: [
                    TextSpan(
                        text: "用户服务协议",
                        style: TextStyle(color: Color(0xFFF9445D)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Navigator.pushNamed(
                                context, "user_server_protocol_page");
                          }),
                    TextSpan(text: "》和《"),
                    TextSpan(
                        text: "隐私政策",
                        style: TextStyle(color: Color(0xFFF9445D)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            Navigator.pushNamed(context, "privacy_policy_page");
                          }),
                    TextSpan(text: "》的全部条款，接受全部条款后，再开始使用我们的服务。")
                  ]),
            ),
            actionsOverflowDirection: VerticalDirection.up,
            actions: <Widget>[
              TextButton(
                child: Text("同意"),
                onPressed: () => ToastUtil.info("此功能暂不开放"), // 关闭对话框
              ),
              TextButton(
                child: Text("不同意"),
                onPressed: () {
                  //关闭对话框并返回true
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }
}
