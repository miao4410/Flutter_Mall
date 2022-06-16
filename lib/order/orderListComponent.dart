import 'package:flutter/material.dart';
import 'package:mall/order/routePageComponent.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:mall/util/ToastUtil.dart';

import 'ButtonEntity.dart';
import 'buttonGroupsComponent.dart';

Widget orderListComponent(BuildContext context, List orderList) {
  return ListView.builder(
    itemCount: orderList.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              color: Colors.white,
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderList[index]["createTimeStr"].toString(),
                    style: TextStyle(color: Color(0xFFABA4A5), fontSize: 12),
                  ),
                  getOrderStatusStr(orderList[index]["status"]),
                ],
              ),
            ),
            Column(
              children: getDetailWidget(orderList[index]["details"]),
            ),
            Container(
              alignment: Alignment.centerRight,
              color: Colors.white,
              height: 40,
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              child:
                  Text("实际付款    " + orderList[index]["totalPrice"].toString()),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
              height: 40,
              padding: EdgeInsets.fromLTRB(0, 4, 16, 4),
              child: getBtnGroups(
                  context, orderList[index]["status"], orderList[index]["id"]),
            ),
          ],
        ),
      );
    },
  );
}

Widget getOrderStatusStr(num status) {
  if (status == 0) {
    return Text(
      "待付款",
      style: TextStyle(color: Color(0xFFF9445D), fontSize: 12),
    );
  }
  if (status == 1) {
    return Text(
      "待发货",
      style: TextStyle(color: Color(0xFFF9445D), fontSize: 12),
    );
  }
  if (status == 2) {
    return Text(
      "待收货",
      style: TextStyle(color: Color(0xFF443E3F), fontSize: 12),
    );
  }
  if (status == 3) {
    return Text(
      "已签收",
      style: TextStyle(color: Color(0xFFF9445D), fontSize: 12),
    );
  }
  if (status == 4) {
    return Text(
      "已确认",
      style: TextStyle(color: Color(0xFFABA4A5), fontSize: 12),
    );
  }
  if (status == 5) {
    return Text(
      "已取消",
      style: TextStyle(color: Color(0xFFF9445D), fontSize: 12),
    );
  }
  if (status == 6) {
    return Text(
      "已删除",
      style: TextStyle(color: Color(0xFFABA4A5), fontSize: 12),
    );
  }
  if (status == 7) {
    return Text(
      "已完成",
      style: TextStyle(color: Color(0xFF443E3F), fontSize: 12),
    );
  }

  return Text("");
}

List<Widget> getDetailWidget(List orderDetail) {
  List<Widget> tiles = [];
  orderDetail.forEach((element) {
    tiles.add(Container(
        height: 98,
        margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                  HttpUtil.httpUrl + element["product"]["images"]),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      element["product"]["name"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color(0xFF443E3F),
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

Widget getBtnGroups(BuildContext context, int status, String orderId) {
  List<ButtonEntity> buttonsStr = [];

  if (status == 0) {
    var buttonComponent = ButtonEntity("付款", 0xFFF9445D, () => goToOrderPREPage(context, orderId));
    buttonsStr.add(buttonComponent);
  }
  if (status == 1 || status == 3 || status == 4 || status == 5 || status == 7) {
    var buttonComponent = ButtonEntity("查看详情", 0xFF443E3F, () => goToDetailPage(context, orderId));
    buttonsStr.add(buttonComponent);
  }

  if (status == 2) {
    var buttonComponent = ButtonEntity("查看详情", 0xFF443E3F, () => goToDetailPage(context, orderId));
    var buttonComponent1 = ButtonEntity("确认收货", 0xFF443E3F, () => ToastUtil.info("此功能尚未开放"));

    buttonsStr.add(buttonComponent);
    buttonsStr.add(buttonComponent1);
  }

  List<Widget> buttonGroup =
      getBtnGroupsComponent(context, buttonsStr, orderId);

  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: buttonGroup,
  );
}
