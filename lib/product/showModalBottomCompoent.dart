import 'package:flutter/material.dart';
import 'package:mall/util/HttpUtil.dart';

// 商品点击购买弹框
void showModalBottomComponent(Map product, BuildContext context) {

  int productCount = 0;
  List<String> productColorList = [];
  if (product["productColor"] != null &&
      product["productColor"].toString().endsWith(",")) {
    productColorList = product["productColor"].toString().split(",");
    productColorList.removeLast();
  }
  List<String> productSizeList = [];
  if (product["productSize"] != null &&
      product["productSize"].toString().endsWith(",")) {
    productSizeList = product["productSize"].toString().split(",");
    productSizeList.removeLast();
  }

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Container(
              height: 120,
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(HttpUtil.httpUrl + product["images"]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "￥" + product["price"].toString(),
                        style:
                            TextStyle(fontSize: 22, color: Color(0xFFFA768A)),
                      ),
                      Text(
                        "原价 " + product["oldPrice"].toString(),
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFFA1A9AA)),
                      ),
                      Text(
                        "库存 " + product["count"].toString(),
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFFA1A9AA)),
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.close))
                ],
              )),
          // 分割线
          Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          // 颜色
          Container(
            child: Column(children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 12, 0, 0),
                    child: Text(
                      "颜色",
                      style: TextStyle(fontSize: 12, color: Color(0xFF443E3F)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 12, 0, 12),
                    height: 28,
                    width: 56,
                    child: MaterialButton(
                      child: Text(
                        "黑色",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF443E3F)),
                      ),
                      color: Color(0xFFE9E9E9),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 12, 0, 12),
                    height: 28,
                    width: 56,
                    child: MaterialButton(
                      child: Text(
                        "黑色",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF443E3F)),
                      ),
                      color: Color(0xFFFA768A),
                      // focusColor: Color(0xFFFA768A),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ]),
          ),
          // 分割线
          Divider(
            height: 1,
            thickness: 0.5,
            indent: 16,
            endIndent: 16,
          ),
          // 尺寸
          Container(
            child: Column(children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Text(
                      "尺寸",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 12, 0, 12),
                        height: 28,
                        width: 56,
                        child: MaterialButton(
                          child: Text(
                            "L",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF443E3F)),
                          ),
                          color: Color(0xFFE9E9E9),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16, 12, 0, 12),
                        height: 28,
                        width: 56,
                        child: MaterialButton(
                          child: Text(
                            "XL",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF443E3F)),
                          ),
                          color: Color(0xFFE9E9E9),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),

          Divider(
            height: 1,
            thickness: 0.5,
            indent: 16,
            endIndent: 16,
          ),

          // 数量选择
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(16, 12, 0, 12),
                child: Text("数量选择"),),
              Container(child: Container(
                margin: EdgeInsets.fromLTRB(0, 12, 16, 12),
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.add, color: Color(0xFFA1A9AA)),
                        onPressed: () {
                          productCount ++ ;
                        },
                      ),
                    ),
                    Container(
                      child: Text(productCount.toString()),
                    ),
                    Container(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.remove, color: Color(0xFFA1A9AA)),
                        onPressed: () {
                          productCount -- ;
                        },
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),

          // 弹框中的底部按钮
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: 220,
              height: 36,
              child: MaterialButton(
                  color: Colors.amber,
                  child: Text(
                    "确认",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))))),
        ],
      );
    },
  );
}


// 获取颜色 尺寸 选择器数组
getWidgetList(List list) {
  List<Widget> widget = [];
  for (int i = 0; i < list.length; i++) {
    widget.add(Text(list[i]));
  }
  return widget;
}
