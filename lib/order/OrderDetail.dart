import 'package:flutter/material.dart';
import 'package:mall/component/myAppBarComponent.dart';
import 'package:mall/order/buttonGroupsComponent.dart';
import 'package:mall/order/routePageComponent.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:mall/util/ToastUtil.dart';

import 'ButtonEntity.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({
    required Key key,
    // 接收一个参数 订单详情id
    required this.orderId,
  }) : super(key: key);

  final String orderId;

  @override
  State<StatefulWidget> createState() {
    return OrderDetailState();
  }
}

class OrderDetailState extends State<OrderDetailPage> {
  // 订单实体类
  var order = Map();
  List orderDetails = [];
  var shippingAddress = Map();

  // 收货地址--用户名和手机号
  String usernameAndTelephone = "";

  // 收货地址--所属区域和详细地址
  String districtAndAddress = "";

  // 支付方式
  String payType = "----";

  @override
  void initState() {
    String orderId = widget.orderId;
    super.initState();
    HttpUtil.get("/order/get", {"orderId": orderId}, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        order = result["data"];
        if (order["payType"] != null) {
          payType = order["payType"] == 0 ? "支付宝" : "微信支付";
        }
        if (order["username"] != null && order["telephone"] != null) {
          usernameAndTelephone =
              order["username"] + "    " + order["telephone"];
        }
        if (order["district"] != null && order["address"] != null) {
          districtAndAddress = order["district"] + "    " + order["address"];
        }
        if (order["details"] != null) {
          orderDetails = order["details"];
        }
        setState(() {});
      }
    }, (error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBarComponent(context, "订单详情"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 收获地址
              Container(
                  alignment: Alignment.center,
                  height: 102,
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                      districtAndAddress,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0XFF443E3F),
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      usernameAndTelephone,
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFABA4A5),
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  )),
              // 订单详情列表
              Container(
                child: Column(
                  children: getDetailWidget(orderDetails),
                ),
              ),
              // 支付方式
              Container(
                color: Colors.white,
                height: 44,
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "支付方式",
                      style: TextStyle(color: Color(0xFF443E3F), fontSize: 12),
                    ),
                    Text(
                      payType,
                      style: TextStyle(color: Color(0xFFABA4A5), fontSize: 12),
                    ),
                  ],
                ),
              ),
              // 商品价格与运费
              Container(
                color: Colors.white,
                height: 76,
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "商品价格",
                          style:
                              TextStyle(color: Color(0xFF443E3F), fontSize: 12),
                        ),
                        Text(
                          order["totalPrice"].toString(),
                          style: TextStyle(color: Color(0xFFF9445D)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "运费",
                          style:
                              TextStyle(color: Color(0xFF443E3F), fontSize: 12),
                        ),
                        Text(
                          "0.00",
                          style: TextStyle(color: Color(0xFFF9445D)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // 订单编号 与交易时间
              Container(
                color: Colors.white,
                height: 76,
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "订单编号",
                          style:
                              TextStyle(color: Color(0xFF443E3F), fontSize: 12),
                        ),
                        Text(
                          order["id"] != null ? order["id"].toString() : "",
                          style: TextStyle(color: Color(0xFFABA4A5)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "交易时间",
                          style:
                              TextStyle(color: Color(0xFF443E3F), fontSize: 12),
                        ),
                        Text(
                            order["createTime"] != null ?  DateTime.fromMillisecondsSinceEpoch(
                                order["createTime"])
                                .toString() : "",

                          style: TextStyle(color: Color(0xFFABA4A5)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 46,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: getBtnGroups(context, order["status"] != null ? order["status"] : 0,
                  order["id"] != null ? order["id"].toString() : ""),
            ),
          ),
        ));
  }

  // for循环生成订单详情
  List<Widget> getDetailWidget(List orderDetail) {
    List<Widget> orderDetailWidget = [];
    orderDetail.forEach((element) {
      orderDetailWidget.add(Container(
          height: 98,
          margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: Image.network(
                    HttpUtil.httpUrl + element["product"]["images"]),
                flex: 3,
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        element["product"]["name"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xFFFFFF),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        element["productSize"].toString() +
                            "," +
                            element["productColor"].toString(),
                        style: TextStyle(color: Color(0xFFABA4A5)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 76,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "￥" + element["productPrice"].toString(),
                              style: TextStyle(color: Color(0xFFFA768A)),
                            ),
                            Text("数量 * " + element["productCount"].toString()),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )));
    });
    return orderDetailWidget;
  }

  // for循环生成订单详情
  List<Widget> getBtnGroups(BuildContext context, int status, String orderId) {
    List<ButtonEntity> buttonsStr = [];

    // 待付款
    if (status == 0) {
      var buttonComponent = ButtonEntity("付款", 0xFFF9445D, () => goToOrderPREPage(context, orderId));
      buttonsStr.add(buttonComponent);
    }
    // 待发货 待收货
    if (status == 1 || status == 2 || status == 4 || status == 5) {
      var buttonComponent = ButtonEntity("确认收货", 0xFFF9445D, () => ToastUtil.info("此功能尚未开放"));
      var buttonComponent1 = ButtonEntity("查看物流", 0xFF443E3F, () => ToastUtil.info("此功能尚未开放"));
      var buttonComponent2 = ButtonEntity("申请发票", 0xFF443E3F, () => ToastUtil.info("此功能尚未开放"));
      buttonsStr.add(buttonComponent);
      buttonsStr.add(buttonComponent1);
      buttonsStr.add(buttonComponent2);
    }
    // 已完成
    if (status == 7) {
      var buttonComponent =
          ButtonEntity("申请发票", 0xFF443E3F, ToastUtil.info("此功能尚未开放"));
      buttonsStr.add(buttonComponent);
    }

    return getBtnGroupsComponent(context, buttonsStr, orderId);
  }
}
