import 'package:flutter/material.dart';
import 'package:mall/order/OrderIndex.dart';
import 'package:mall/util/ToastUtil.dart';

Widget orderColumn(Map orderCountGroupByStatus, BuildContext context) {
  int dfkCount = 0;
  if (orderCountGroupByStatus["dfk"] != null) {
    dfkCount = orderCountGroupByStatus["dfk"];
  }
  int dfhCount = 0;
  if (orderCountGroupByStatus["dfh"] != null) {
    dfhCount = orderCountGroupByStatus["dfh"];
  }
  int dshCount = 0;
  if (orderCountGroupByStatus["dsh"] != null) {
    dshCount = orderCountGroupByStatus["dsh"];
  }

  return Row(
    children: [
      Expanded(
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderIndexPage(status: 1, key: UniqueKey(),)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text("$dfkCount",
                      style: TextStyle(
                          color: Color(0xFF443E3F),
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("待付款",
                      style: TextStyle(color: Color(0xFFABA4A5), fontSize: 14)),
                ),
              ],
            )),
        flex: 1,
      ),
      Expanded(
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderIndexPage(status: 2, key: UniqueKey(),)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text("$dfhCount",
                      style: TextStyle(
                          color: Color(0xFF443E3F),
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("待发货",
                      style: TextStyle(color: Color(0xFFABA4A5), fontSize: 14)),
                ),
              ],
            )),
        flex: 1,
      ),
      Expanded(
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderIndexPage(status: 3, key: UniqueKey(),)));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text("$dshCount",
                      style: TextStyle(
                          color: Color(0xFF443E3F),
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("待收货",
                      style: TextStyle(color: Color(0xFFABA4A5), fontSize: 14)),
                ),
              ],
            )),
        flex: 1,
      ),
      Expanded(
        child: InkWell(
            onTap: () {
              ToastUtil.info("此功能尚未开放");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text("--",
                      style: TextStyle(
                          color: Color(0xFF443E3F),
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text("退款",
                      style: TextStyle(color: Color(0xFFABA4A5), fontSize: 14)),
                ),
              ],
            )),
        flex: 1,
      ),
    ],
  );
}
