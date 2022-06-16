import 'package:flutter/material.dart';
import 'package:mall/component/listTitleComponent.dart';
import 'package:mall/component/myAppBarComponent.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall/domain/GlobalValue.dart';
import 'package:mall/person/About.dart';
import 'package:mall/shippingAddress/ShippingAddress.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBarComponent(context, "设置"),
      body: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text("昵称"),
              trailing: Text(GlobalValue.nickname),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          listTitleComponent(context, "发票信息", null),
          listTitleComponent(
              context, "收货地址", ShippingAddressPage(fromType: "person", key: UniqueKey(),)),
          SizedBox(
            height: 8.h,
          ),
          listTitleComponent(context, "关于", AboutPage()),
          SizedBox(
            height: 8.h,
          ),
          Container(
            height: 50.h,
            width: double.infinity,
            color: Colors.white,
            child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {
                    bool delete = await showLogout();
                    if (delete == true) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "google_login_page", (Route<dynamic> route) => false);
                    }
                  },
                  child: Text(
                    "退出登录",
                    style: TextStyle(color: Color(0xFFF9445D), fontSize: 16.sp),
                  ),
                )),
          )
        ],
      ),
    );
  }

   showLogout() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要退出登录?"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            TextButton(
              child: Text("确定"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
