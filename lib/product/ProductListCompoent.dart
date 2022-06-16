import 'package:flutter/material.dart';
import 'package:mall/util/HttpUtil.dart';

import 'Product.dart';

Widget productListComponent(BuildContext context, List productList) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: const EdgeInsets.all(8),
    child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // 横轴子元素的数量
            crossAxisCount: 2,
            // 子元素在横轴长度和主轴长度的比例
            childAspectRatio: 0.7),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // 这里不判断 不影响运行  但控制台会报错
              if (productList[index]["id"] != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductPage(id: productList[index]["id"], key: UniqueKey(),)));
              }
            },
            child: Column(
              children: [
                Container(
                  width: (size.width - 45) / 2,
                  height: (size.width - 45) / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                    ),
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          HttpUtil.httpUrl + productList[index]["images"],
                        )),
                  ),
                  // 图片加载 因FadeInImage会把圆角覆盖 暂时不用
                  /* child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: HttpUtil.httpUrl +
                          productList[index]["images"],
                    ),*/
                ),
                Container(
                  width: (size.width - 45) / 2,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Column(
                    children: [
                      Text(
                        productList[index]["name"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text("会员价",
                                  style: TextStyle(color: Colors.pinkAccent),
                                  textAlign: TextAlign.left),
                            ),
                            Expanded(
                              child: Text("原价",
                                  style: TextStyle(color: Colors.black26),
                                  textAlign: TextAlign.right),
                            )
                          ],
                        ),
                      ),
                      Container(
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(0, 5)),
                          ),
                          margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                          padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                productList[index]["price"].toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                              Expanded(
                                  child: Text(
                                productList[index]["oldPrice"].toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        }),
  );
}
