import 'package:flutter/material.dart';
import 'package:mall/product/ProductListCompoent.dart';
import 'package:mall/util/ToastUtil.dart';

Widget noShoppingCart(BuildContext context, List productList) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        color: Colors.white,
        height: 44,
        padding: EdgeInsets.fromLTRB(16, 9, 16, 9),
        child: Text(
          "购物车",
          style: TextStyle(fontSize: 18),
        ),
      ),
      Container(
        height: 280,
        margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
                  "assets/images/shoppingCart/img_shopping_empty.jpg",
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 196, 0, 0),
              child: Text(
                "购物车还是空的",
                style: TextStyle(fontSize: 12, color: Color(0xFFABA4A5)),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: MaterialButton(
                  onPressed: () {
                    ToastUtil.info("此功能尚未开放");
                  },
                  minWidth: 20,
                  color: Colors.red,
                  child: Text(
                    "去逛逛",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)))),
            ),
          ],
        ),
      ),



      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(16, 17, 0, 0),
        child: Text(
          "猜你喜欢",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      Expanded(child: productListComponent(context, productList))

      // 管理或完成 文字
    ],
  );
}
