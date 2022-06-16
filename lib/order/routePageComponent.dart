import 'package:flutter/material.dart';

import 'OrderDetail.dart';
import 'OrderPRE.dart';

// 跳转到订单详情页面
void goToDetailPage(BuildContext context, String orderId) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OrderDetailPage(orderId: orderId, key: UniqueKey(),)));
}

// 跳转待付款页面
void goToOrderPREPage(BuildContext context, String orderId) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => OrderPREPage(id: orderId, key: UniqueKey(),)));
}
