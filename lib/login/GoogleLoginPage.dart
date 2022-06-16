import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall/domain/GlobalValue.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:mall/util/SharedPreferenceUtil%20.dart';
import 'package:mall/util/ToastUtil.dart';

class GoogleLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GoogleLoginState();
  }
}

class GoogleLoginState extends State<GoogleLoginPage> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final purpleColor = Color(0xff6688FF);
  final darkTextColor = Color(0xff1F1A3D);
  final lightTextColor = Color(0xff999999);
  final textFieldColor = Color(0xffF5F6FA);
  final borderColor = Color(0xffD9D9D9);

  @override
  void initState() {
    super.initState();
    setState(() {
      initializeLoginForm();
    });
  }

  Widget getTextField(
      {required String hint,
      required TextEditingController controller,
      required bool obscureText,
      required Function f}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {return f(value);},
      toolbarOptions:
          ToolbarOptions(copy: true, cut: true, selectAll: true, paste: true),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          filled: true,
          fillColor: textFieldColor,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 52.h,
              ),
              Text(
                "Sign Up to FeiTong Mall",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: darkTextColor,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 66.h, 0, 66.h),
                width: 92.0.r,
                height: 92.0.r,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: new DecorationImage(
                        image:
                            AssetImage("assets/images/login/login-icon.png"))),
              ),
              Form(
                  key: _formKey, //设置globalKey，用于后面获取FormState
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      getTextField(
                          hint: "Full Name Or Telephone",
                          controller: _usernameController,
                          obscureText: false,
                          f: (value) {
                            if (value == null) {
                              return "请输入用户名";
                            }
                            if (value.trim().length > 16 ||
                                value.trim().length < 4) {
                              return "用户名长度不能小于4位或大于16位";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 16.h,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // 密码输入框
                      getTextField(
                          hint: "Password",
                          controller: _passwordController,
                          obscureText: true,
                          f: (value) {
                            if (value == null) {
                              return "请输入密码";
                            }
                            if (value.trim().length > 12 ||
                                value.trim().length < 8) {
                              return "密码长度不能小于8位或大于12位";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 32.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            login(context);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(purpleColor),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 14.h)),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ))),
                          child: Text("Login"),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                height: 16.h,
              ),
              Wrap(
                children: [
                  Text(
                    "If you wish to create a new account please click the ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: lightTextColor,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      "Register Account",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: purpleColor,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "google_register_page");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 登录按钮触发的事件
  login(BuildContext context) {
    EasyLoading.show();
    String username = _usernameController.text;
    String password = _passwordController.text;
    HttpUtil.post("/login", {"username": username, "password": password},
        (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        SharedPreferenceUtil.saveUser(username, password);
        HttpUtil.token = result["data"]["token"].toString();
        GlobalValue.nickname = result["data"]["nickname"].toString();
        GlobalValue.username = result["data"]["username"].toString();
        GlobalValue.email = result["data"]["email"].toString();
        GlobalValue.avatar = result["data"]["avatar"].toString();
        GlobalValue.sex = result["data"]["sex"].toString();
        GlobalValue.telephone = result["data"]["telephone"].toString();
        // LoggerUtil.info("token:" + HttpUtil.token);
        Navigator.pushNamed(context, "index_page");
        EasyLoading.dismiss();
      } else {
        ToastUtil.error(result["msg"]);
      }
      EasyLoading.dismiss();
    }, (error) {
      EasyLoading.dismiss();
      ToastUtil.error("服务器连接异常");
    });
  }

  /// 获取表单
  void initializeLoginForm() async {
    _usernameController.text = await SharedPreferenceUtil.getFormUsername();
    _passwordController.text = await SharedPreferenceUtil.getFormPassword();
  }
}
