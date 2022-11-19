import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall/Splash.dart';
import 'package:mall/category/Category.dart';
import 'package:mall/codeFun/codeFun.dart';
import 'package:mall/home/Home.dart';
import 'package:mall/Index.dart';
import 'package:mall/login/GoogleRegisterPage.dart';
import 'package:mall/login/Login.dart';
import 'package:mall/login/PrivacyPolicyPage.dart';
import 'package:mall/login/UserServerProtocolPage.dart';
import 'package:mall/person/Person.dart';
import 'package:mall/person/Setting.dart';
import 'package:mall/search/HomeSearchList.dart';

import 'package:mall/shoppingCart/ShoppingCart.dart';
import 'package:mall/testPage//InfiniteListView.dart';
import 'package:mall/testPage/photoPage.dart';

import 'login/GoogleLoginPage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    // 展示时间, 默认2000ms
    ..displayDuration = const Duration(milliseconds: 2000)
    // 图标效果
    ..indicatorType = EasyLoadingIndicatorType.circle
    // 加载样式, 默认[EasyLoadingStyle.dark].
    ..loadingStyle = EasyLoadingStyle.light
    // 遮罩颜色
    ..maskType = EasyLoadingMaskType.black
    // 指示器大小
    // ..indicatorSize = 45.0
    // 指示器圆角大小
    ..radius = 10.0
    // 进度条指示器的颜色, 仅对[EasyLoadingStyle.custom]有效.
    ..progressColor = Colors.yellow
    // loading的背景色
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    // 加载位置  底部
    ..toastPosition = EasyLoadingToastPosition.bottom
    // 文字颜色
    ..textColor = Colors.yellow
    // 遮罩颜色
    ..maskColor = Colors.blue.withOpacity(0.5)
    // 显示加载时是否允许用户交互
    ..userInteractions = false
    // 点击是否消失
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  static const List<Locale> supportLocaels = <Locale>[
    Locale("en"),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 解决中文日期问题 例如显示“周五“会异常
    initializeDateFormatting('az');

    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              // 背景颜色 画板颜色
              scaffoldBackgroundColor: Color.fromRGBO(249, 249, 249, 1.0),
            ),
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            routes: {
              "home_page": (context) => HomePage(),
              "login_page": (context) => LoginPage(key: UniqueKey()),
              "index_page": (context) => IndexPage(key: UniqueKey()),
              "category_page": (context) => CategoryPage(),
              "shopping_cart_page": (context) => ShoppingCartPage(),
              "person_page": (context) => PersonPage(),
              "user_server_protocol_page": (context) =>
                  UserServerProtocolPage(),
              "privacy_policy_page": (context) => PrivacyPolicyPage(),
              "infinite_list_view": (context) => InfiniteListView(),
              "google_register_page": (context) => GoogleRegisterPage(),
              "google_login_page": (context) => GoogleLoginPage(),
              "setting_page": (context) => SettingPage(),
              "splash_page": (context) => SplashPage(),
              "HomeSearchListPage": ((context) => HomeSearchListPage(
                    key: UniqueKey(),
                    productName: "",
                  )),
              "PhotoBrowsePage": (context) => PhotoBrowsePage(),
              "funCodePage": (context) => CodeFunPage()
            },
            initialRoute: "google_register_page",
          );
        });
  }
}
