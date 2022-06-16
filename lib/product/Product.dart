import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:mall/component/myAppBarComponent.dart';
import 'package:mall/order/OrderPRE.dart';
import 'package:mall/product/showModalBottomCompoent.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:mall/util/ToastUtil.dart';

class ProductPage extends StatefulWidget {
  ProductPage({
    required Key key,
    // 接收一个text参数
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<StatefulWidget> createState() {
    return ProductState();
  }
}

class ProductState extends State<ProductPage> {
  var product = Map();
  bool collectFlag = false;
  int shoppingCarCount = 1;
  String shoppingCartSize = "";
  String shoppingCartColor = "";
  String priceInteger = "";
  String priceDecimal = "";

  // 写死的 后期
  List<String> imageList = [];
  int currentIndex = 0;
  @override
  void initState() {
    int _id = widget.id;
    super.initState();
    HttpUtil.get("/product/get", {"id": _id}, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        product = result["data"];
        String productPrice = product["price"].toString();
        priceInteger = productPrice.substring(0, productPrice.indexOf("."));
        priceDecimal = productPrice.substring(productPrice.indexOf("."));
        List<String> list = product["listImg"].toString().split(",");
        list.removeLast();
        list.forEach((element) {
          imageList.add(HttpUtil.httpUrl + element);
        });
        if (mounted) {
          setState(() {});
        }
      }
    }, (error) {});

    // 用_futureBuilderFuture来保存_gerData()的结果，以避免不必要的ui重绘
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBarComponent(context, "商品详情"),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // 轮播图
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: size.width,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            ),
            width: double.infinity,
            child: Stack(
              children: [
                // 轮播图片
                builderBannerWidget(),
                // 指示器
                buildTipWidget(),
              ],
            ),
          ),
          // 商品标题
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Column(
              children: [
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "￥",
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            priceInteger,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            priceDecimal,
                            style: TextStyle(
                              color: Colors.pinkAccent,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "会员价",
                            style: TextStyle(color: Colors.pinkAccent),
                          )
                        ],
                      ),
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "原价",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "￥" + product["oldPrice"].toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                  ],
                )),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    product["name"].toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          // 发货
          Container(
            height: 44,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
            padding: EdgeInsets.fromLTRB(16, 10.5, 16, 10.5),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "发货",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    flex: 6,
                    child: Text(
                      "单次消费满 1000 免快递费用",
                      style: TextStyle(fontSize: 12),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      "快递：0.00",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
          ),
          // 选择尺码
          Container(
            height: 44,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
            padding: EdgeInsets.fromLTRB(16, 10.5, 16, 10.5),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text(
                      "选择",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    flex: 6,
                    child: Text(
                      "42码, 红白配色",
                      style: TextStyle(fontSize: 12),
                    )),
                Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black26,
                    ))
              ],
            ),
          ),
          // 商品详情
          Container(
            height: 44,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
            padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
            alignment: Alignment.centerLeft,
            child: Text(
              "商品详情",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          // 商品详情下的图片
          Container(
            width: size.width,
            child: Image.network(
              HttpUtil.httpUrl + "/file/mall/product/info.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    collectFlag = !collectFlag;
                  });
                },
                child: Container(
                    width: 40,
                    height: 50,
                    child: Column(
                      children: [
                        Container(
                          height: 16,
                          child: Icon(
                            Icons.grade,
                            color: collectBtn(collectFlag),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          height: 16,
                          child: Text(
                            "收藏",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black26),
                          ),
                        ),
                      ],
                    )),
              ),
              // 加入购物车
              Container(
                  width: 110,
                  height: 36,
                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: MaterialButton(
                      color: Colors.amber,
                      child: Text(
                        "加入购物车",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        _showModalBottomSheet(0);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100))))),
              // 立即购买
              Container(
                  width: 110,
                  height: 36,
                  margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: MaterialButton(
                      color: Colors.red,
                      child: Text(
                        "立即购买",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      onPressed: () {
                        //showModalBottomComponent(product, context);
                        _showModalBottomSheet(1);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100))))),
            ],
          ),
        ),
      ),
    );
  }

  builderBannerWidget() {
    return ExtendedImageGesturePageView.builder(
      itemBuilder: (BuildContext context, int index) {
        Widget image = ExtendedImage.network(
          imageList[index],
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
        );
        image = Container(
          child: image,
          padding: EdgeInsets.all(5.0),
        );
        if (index == currentIndex) {
          return Hero(
            tag: imageList[index] + index.toString(),
            child: image,
          );
        } else {
          return image;
        }
      },
      itemCount: imageList.length,
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      // controller: PageController(
      //   initialPage: widget.currentIndex,
      // ),
      scrollDirection: Axis.horizontal,
    );
  }

  buildTipWidget() {
    return Container(
      height: 20,
      child: Text("123"),
    );
  }

  // 添加购物车
  addCart(productId, shoppingColor, shoppingSize, shoppingCount) {
    // LoggerUtil.info("productId" + "${productId}");
    HttpUtil.post("/cart/add", {
      "productId": productId,
      "productColor": shoppingColor,
      "productSize": shoppingSize,
      "productCount": shoppingCount
    }, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        ToastUtil.info(result["msg"]);
        Navigator.pop(context);
      } else {
        ToastUtil.error(result["msg"]);
      }
    }, (error) {});
  }

  // 点击收藏按钮触发的函数
  collectBtn(bool collectFlag) {
    return collectFlag == false ? Colors.grey : Colors.amber;
  }

  // 底部弹框 flag = 0 加入购物车  flag = 1 立即购买
  _showModalBottomSheet(int flag) {
    List<String> productColorList = [];
    List<bool> productColorSelected = [];
    if (product["productColor"] != null &&
        product["productColor"].toString().endsWith(",")) {
      productColorList = product["productColor"].toString().split(",");
      productColorList.removeLast();
      productColorSelected =
          List.generate(productColorList.length, (index) => false);
    }
    List<String> productSizeList = [];
    List<bool> productSizeSelected = [];
    if (product["productSize"] != null &&
        product["productSize"].toString().endsWith(",")) {
      productSizeList = product["productSize"].toString().split(",");
      productSizeList.removeLast();
      productSizeSelected =
          List.generate(productSizeList.length, (index) => false);
    }

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, setState) => Column(
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
                                  style: TextStyle(
                                      fontSize: 22, color: Color(0xFFFA768A)),
                                ),
                                Text(
                                  "原价 " + product["oldPrice"].toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFFA1A9AA)),
                                ),
                                Text(
                                  "库存 " + product["count"].toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFFA1A9AA)),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.close)),
                            )
                          ],
                        )),
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                    ),

                    // 颜色
                    Container(
                      height: 88,
                      child: Column(children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(16, 12, 0, 0),
                              child: Text(
                                "颜色",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFF443E3F)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 6, 0, 0),
                              child: ToggleButtons(
                                children: getWidgetList(productColorList),
                                color: Colors.green,
                                constraints: BoxConstraints(
                                  minHeight: 28,
                                  minWidth: 56,
                                ),
                                fillColor: Color(0xFFFA768A),
                                selectedColor: Colors.red,
                                isSelected: productColorSelected,
                                onPressed: (int index) {
                                  shoppingCartColor =
                                      productColorList[index].toString();
                                  setState(() {
                                    for (int buttonIndex = 0;
                                        buttonIndex <
                                            productColorSelected.length;
                                        buttonIndex++) {
                                      if (buttonIndex == index) {
                                        productColorSelected[buttonIndex] =
                                            !productColorSelected[buttonIndex];
                                      } else {
                                        productColorSelected[buttonIndex] =
                                            false;
                                      }
                                    }
                                  });
                                },
                              ),
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

                    // 尺寸
                    Container(
                      height: 88,
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
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 6, 0, 0),
                              child: ToggleButtons(
                                children: getWidgetList(productSizeList),
                                color: Colors.green,
                                constraints: BoxConstraints(
                                  minHeight: 28,
                                  minWidth: 56,
                                ),
                                fillColor: Color(0xFFFA768A),
                                selectedColor: Colors.red,
                                isSelected: productSizeSelected,
                                onPressed: (int index) {
                                  shoppingCartSize =
                                      productSizeList[index].toString();
                                  setState(() {
                                    for (int buttonIndex = 0;
                                        buttonIndex <
                                            productSizeSelected.length;
                                        buttonIndex++) {
                                      if (buttonIndex == index) {
                                        productSizeSelected[buttonIndex] =
                                            !productSizeSelected[buttonIndex];
                                      } else {
                                        productSizeSelected[buttonIndex] =
                                            false;
                                      }
                                    }
                                  });
                                },
                              ),
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
                          child: Text("数量选择"),
                        ),
                        Container(
                            child: Container(
                          margin: EdgeInsets.fromLTRB(0, 12, 16, 12),
                          child: Row(
                            children: [
                              Container(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon:
                                      Icon(Icons.add, color: Color(0xFFA1A9AA)),
                                  onPressed: () {
                                    setState(() {
                                      if (shoppingCarCount < 99) {
                                        shoppingCarCount++;
                                      }
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: Text(shoppingCarCount.toString()),
                              ),
                              Container(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.remove,
                                      color: Color(0xFFA1A9AA)),
                                  onPressed: () {
                                    setState(() {
                                      if (shoppingCarCount > 1) {
                                        shoppingCarCount--;
                                      }
                                    });
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            onPressed: () {
                              if (flag == 0) {
                                addCart(product["id"], shoppingCartColor,
                                    shoppingCartSize, shoppingCarCount);
                              } else {
                                HttpUtil.post("/order/add/product", {
                                  "productId": product["id"],
                                  "productCount": shoppingCarCount,
                                  "productPrice": product["price"],
                                  "productColor": shoppingCartColor,
                                  "productSize": shoppingCartSize,
                                }, (data) {
                                  Map<String, dynamic> result = data;
                                  if (result["code"] == 0) {
                                    ToastUtil.info("订单创建成功");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OrderPREPage(
                                                  id: result["data"].toString(),
                                                  key: UniqueKey(),
                                                )));
                                  } else {
                                    ToastUtil.info(result["msg"]);
                                  }
                                }, (error) {});
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))))),
                  ],
                ));
      },
    );
  }
}
