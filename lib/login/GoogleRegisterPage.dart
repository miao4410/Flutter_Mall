import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:mall/util/ToastUtil.dart';

class GoogleRegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPasswordController =
      new TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  final purpleColor = Color(0xff6688FF);
  final darkTextColor = Color(0xff1F1A3D);
  final lightTextColor = Color(0xff999999);
  final textFieldColor = Color(0xffF5F6FA);
  final borderColor = Color(0xffD9D9D9);

  Widget getTextField(
      {required String hint,
      required TextEditingController controller,
      required bool obscureText,
      required Function f }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {return f(value);},
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52.h,
              ),
              Text(
                "Sign Up to Masterminds",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: darkTextColor,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Wrap(
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: lightTextColor,
                      ),
                    ),
                    TextSpan(
                        text: "Login",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: purpleColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "google_login_page");
                          })
                  ])),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              // ????????????
              Form(
                key: _formKey, // ??????globalKey?????????????????????FormState
                // ??????????????????????????????
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    // ??????????????????
                    getTextField(
                        hint: "full name",
                        controller: _usernameController,
                        obscureText: false,
                        f: (value) {
                          if (value == null) {
                            return "??????????????????";
                          }
                          if (value.trim().length > 16 ||
                              value.trim().length < 4) {
                            return "???????????????????????????4????????????16???";
                          }
                          return null;
                        },
                       ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // ???????????????
                    getTextField(
                        hint: "Password",
                        controller: _passwordController,
                        obscureText: true,
                        f: (value) {
                          if (value == null) {
                            return "???????????????";
                          }
                          if (value.trim().length > 12 ||
                              value.trim().length < 8) {
                            return "????????????????????????8????????????12???";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 16.h,
                    ),
                    // ?????????????????????
                    getTextField(
                        hint: "Confirm Password",
                        controller: _confirmPasswordController,
                        obscureText: true,
                        f: (value) {
                          if (value == null) {
                            return "?????????????????????";
                          }
                          if (value.trim().length > 12 ||
                              value.trim().length < 8) {
                            return "??????????????????????????????8????????????12???";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 16.h,
                    ),
                    // ??????????????????
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if ((_formKey.currentState as FormState).validate()) {
                            register(context);
                          }
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
                        child: Text("Create Account"),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(
                    "or sign up via",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: lightTextColor,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(
                        color: borderColor,
                      )),
                      foregroundColor: MaterialStateProperty.all(darkTextColor),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 14.h)),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/login/Google.png"),
                      SizedBox(width: 10.w),
                      Text("Google"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Wrap(
                children: [
                  Text(
                    "By signing up to Masterminds you agree to our ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: lightTextColor,
                    ),
                  ),
                  Text(
                    "terms and conditions",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: purpleColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ????????????
  register(BuildContext context) {
    String username = _usernameController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    if (password != confirmPassword) {
      ToastUtil.error("?????????????????????????????? ???????????????");
      return;
    }
    HttpUtil.post("/register", {
      "username": username,
      "password": password,
    }, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        ToastUtil.info(result["msg"]);
        // LoggerUtil.info("token:" + HttpUtil.token);
      } else {
        ToastUtil.error(result["msg"]);
      }
    }, (error) {
      ToastUtil.error("?????????????????????");
    });
  }
}
