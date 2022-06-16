import 'package:flutter/material.dart';
import 'package:mall/component/myAppBarComponent.dart';
import 'package:mall/shippingAddress/ShippingAddress.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall/util/ToastUtil.dart';

class OrderPREPage extends StatefulWidget {
  OrderPREPage({
    required Key key,
    // 接收一个参数 订单id
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<StatefulWidget> createState() {
    return OrderPREState();
  }
}

class OrderPREState extends State<OrderPREPage> {
  var order = Map();
  var shippingAddress = Map();
  List orderDetails = [];
  num totalCount = 0;
  double totalPrice = 0;

  /// 支付类型 0:支付宝 1:微信
  int payType = 1;

  @override
  void initState() {
    super.initState();
    HttpUtil.get("/shipping/address/query/default", null, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        shippingAddress = result["data"];
        setState(() {});
      }
    }, (error) {});

    String orderId = widget.id;
    HttpUtil.get("/order/get", {"orderId": orderId}, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        order = result["data"];
        if (order["details"] != null) {
          orderDetails = order["details"];
          orderDetails.forEach((element) {
            if (element["productCount"] != null &&
                element["productPrice"] != null) {
              totalCount += element["productCount"];
              totalPrice += element["productPrice"] * element["productCount"];
            }
          });
        }
        setState(() {});
      }
    }, (error) {});
  }

  // for循环生成订单详情
  List<Widget> getDetailWidget(List orderDetail) {
    List<Widget> tiles = [];
    orderDetail.forEach((element) {
      tiles.add(Container(
          height: 98.h,
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
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBarComponent(context, "确认订单信息"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 收获地址
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 0),
                alignment: Alignment.center,
                height: 102.h,
                color: Colors.white,
                child: shippingAddress.length > 0
                    ? shippingDo(shippingAddress)
                    : ListTile(
                        leading: Icon(
                          Icons.location_on_outlined,
                          color: Colors.redAccent,
                        ),
                        title: Text(
                          "填写收货地址",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF443E3F),
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
              ),

              // 付款方式
              Container(
                margin: EdgeInsets.fromLTRB(0, 8.h, 0, 8.h),
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 14.w),
                height: 50.h,
                color: Color(0xFFFFFFFF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("支付方式",
                        style: TextStyle(
                            color: Color(0xFF443E3F), fontSize: 14.sp)),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(payType == 1 ? "微信支付" : "支付宝支付",
                              style: TextStyle(
                                  color: Color(0xFF443E3F), fontSize: 14.sp)),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                      onTap: () async {
                        int value = await _showModalBottomSheet();
                        setState(() {
                          payType = value;
                        });
                      },
                    )
                  ],
                ),
              ),

              // 订单详情列表
              Container(
                child: Column(
                  children: getDetailWidget(orderDetails),
                ),
              ),

              // 商品价格与运费
              Container(
                color: Colors.white,
                height: 76.h,
                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("商品价格"),
                        Text(
                          order["totalPrice"].toString(),
                          style: TextStyle(color: Color(0xFFF9445D)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("运费"),
                        Text(
                          "0.00",
                          style: TextStyle(color: Color(0xFFF9445D)),
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
            height: 46.h,
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  margin: EdgeInsets.fromLTRB(36.w, 0, 0, 0),
                  child: Text(
                    "共 " + totalCount.toString() + " 件",
                    style: TextStyle(color: Color(0xFFABA4A5), fontSize: 12),
                  ),
                ),
                Container(
                  width: 50.w,
                  margin: EdgeInsets.fromLTRB(140.w, 0, 0, 0),
                  child: Text(
                    "￥" + totalPrice.toString(),
                    style: TextStyle(color: Color(0xFFF9445D)),
                  ),
                ),
                Container(
                    width: 88.w,
                    height: 30.h,
                    margin: EdgeInsets.fromLTRB(16.w, 0, 0, 0),
                    child: MaterialButton(
                        color: Color(0xFFF9445D),
                        child: Text(
                          "结算",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onPressed: () {
                          ToastUtil.info("支付类型" + "$payType");
                          // 调用支付弹框
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)))))
              ],
            ),
          ),
        ));
  }

  // 支付底部弹框
  _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, setState) => SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      Expanded(
                          child: RadioListTile(
                        value: 0,
                        groupValue: this.payType,
                        onChanged: (value) {
                          setState(() {
                            this.payType = value as int;
                          });
                          Navigator.of(context).pop(value);
                        },
                        title: Text("支付宝(推荐使用)"),
                        secondary: const Icon(
                            IconData(0xe607, fontFamily: 'appIconFonts')),
                        selected: this.payType == 0,
                      )),
                      // 组合选择项1
                      Expanded(
                          child: RadioListTile(
                        value: 1,
                        groupValue: this.payType,
                        onChanged: (value) {
                          setState(() {
                            this.payType = value as int;
                          });
                          Navigator.of(context).pop(value);
                        },
                        title: Text("微信"),
                        secondary: const Icon(
                            IconData(0xe73b, fontFamily: 'appIconFonts')),
                        selected: this.payType == 1,
                      )),
                    ],
                  ),
                ));
      },
    );
  }

  // 获取收货地址
  Widget shippingDo(Map address) {
    return ListTile(
      leading: Icon(
        Icons.location_on_outlined,
        color: Colors.redAccent,
      ),
      title: Text(
        address["districtAndAddress"],
        style: TextStyle(
            fontSize: 18,
            color: Color(0XFF443E3F),
            fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        address["nameAndPhone"],
        style: TextStyle(
            fontSize: 12,
            color: Color(0xFFABA4A5),
            fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShippingAddressPage(
                      fromType: "order",
                      key: UniqueKey(),
                    ))).then((value) {
          if (value != null) {
            shippingAddress = value;
            setState(() {});
          }
        });
      },
    );
  }
}
