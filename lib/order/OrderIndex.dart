import 'package:flutter/material.dart';
import 'package:mall/util/HttpUtil.dart';

import 'orderListComponent.dart';

class OrderIndexPage extends StatefulWidget {
  OrderIndexPage({
    required Key key,
    // 接收一个参数 订单id
    required this.status,
  }) : super(key: key);

  final int status;

  @override
  State<StatefulWidget> createState() {
    return OrderIndexState();
  }
}

class OrderIndexState extends State<OrderIndexPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Widget> tabArray = [
    Tab(
        child: Text(
      "全部",
      style: TextStyle(color: Colors.black, fontSize: 13),
    )),
    Tab(
        child: Text(
      "待付款",
      style: TextStyle(color: Colors.black, fontSize: 13),
    )),
    Tab(
        child: Text(
      "待发货",
      style: TextStyle(color: Colors.black, fontSize: 13),
    )),
    Tab(
        child: Text(
      "待收货",
      style: TextStyle(color: Colors.black, fontSize: 13),
    )),
    Tab(
        child: Text(
      "退款",
      style: TextStyle(color: Colors.black, fontSize: 13),
    )),
  ];

  // 全部订单
  List orderList = [];
  // 待付款订单
  List dfkOrderList = [];
  // 待发货
  List dfhOrderList = [];
  // 待收货
  List dshOrderList = [];

  @override
  void initState() {
    int status = widget.status;

    super.initState();
    HttpUtil.get("/order/list", null, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        if (result["data"] != null) {
          orderList = result["data"];
        }
        orderList.forEach((element) {
          // 待付款订单
          if (element["status"] == 0) {
            dfkOrderList.add(element);
          }
          // 待发货
          if (element["status"] == 1) {
            dfhOrderList.add(element);
          }
          // 待收货
          if (element["status"] == 2) {
            dshOrderList.add(element);
          }
        });

        setState(() {});
      }
    }, (error) {});

    _tabController =
        TabController(length: 5, vsync: this, initialIndex: status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "我的订单",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        bottom: TabBar(
          tabs: tabArray,
          // 指示器颜色
          indicatorColor: Color(0xFFF9445D),
          // 指示器的高度
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 4.0, //指示器的高度
          controller: _tabController,
          labelStyle:
              TextStyle(color: Color(0xFF443E3F), fontSize: 14), //设置标签样式
          unselectedLabelStyle: TextStyle(
              color: Color(0xFFABA4A5), fontSize: 14), //未选中Tab中文字style
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 全部订单
          orderListComponent(context, orderList),
          // 待付款
          orderListComponent(context, dfkOrderList),
          // 待发货
          orderListComponent(context, dfhOrderList),
          // 待收货
          orderListComponent(context, dshOrderList),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}
