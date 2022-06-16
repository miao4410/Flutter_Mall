import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mall/component/listTitleComponent.dart';
import 'package:mall/order/OrderIndex.dart';
import 'package:mall/person/Setting.dart';
import 'package:mall/person/personInfo.dart';
import 'package:mall/shippingAddress/ShippingAddress.dart';
import 'package:mall/util/HttpUtil.dart';

import 'orderColumn.dart';

class PersonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonPageState();
  }
}

class PersonPageState extends State<PersonPage> {
  var orderCountGroupByStatus = Map();

  @override
  void initState() {
    EasyLoading.show();
    super.initState();
    HttpUtil.get("/order/count/status/group", null, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        orderCountGroupByStatus = result["data"];
        setState(() {});
      }
      EasyLoading.dismiss();
    }, (error) {
      EasyLoading.dismiss();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        body: Column(
          children: [
            // 个人信息组件
            personInfo(),
            // 订单数量栏
            Container(
              height: 42,
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 9, 0, 0),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "我的订单",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderIndexPage(status: 0, key: UniqueKey(),)));
                        },
                        child: Text(
                          "全部订单",
                          style: TextStyle(fontSize: 14),
                        )),
                  )
                ],
              ),
            ),
            // 订单栏
            Container(
              height: 86,
              margin: EdgeInsets.fromLTRB(0, 1, 0, 8),
              color: Colors.white,
              child: orderColumn(orderCountGroupByStatus, context),
            ),
            listTitleComponent(context, "我的收藏",  null),
            listTitleComponent(
                context,
                "我的收货地址",
                ShippingAddressPage(
                  fromType: "person", key: UniqueKey(),
                )),
            listTitleComponent(context, "设置", SettingPage()),
          ],
        ));
  }
}
