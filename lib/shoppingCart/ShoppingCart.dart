import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mall/order/OrderPRE.dart';
import 'package:mall/shoppingCart/noShoppingCart.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:mall/util/LoggerUtil.dart';
import 'package:mall/util/ToastUtil.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShoppingCartState();
  }
}

class ShoppingCartState extends State<ShoppingCartPage> {
  List shoppingCartList = [];
  List<int> ids = [];
  bool managerBtn = false;
  double totalPrice = 0.00;
  bool selectAllBtn = false; //总的复选框控制开关
  List productList = [];

  @override
  void initState() {
    EasyLoading.show();
    super.initState();
    HttpUtil.get("/cart/list", null, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        shoppingCartList = result["data"];
        if (shoppingCartList.length > 0) {
          setState(() {});
        } else {
          getProduct();
        }
        EasyLoading.dismiss();
      }
    }, (error) {
      EasyLoading.dismiss();
    });
  }

  getProduct() {
    HttpUtil.get("/product/list", null, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        productList = result["data"];
        setState(() {});
      }
    }, (error) {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        // ios下更改状态栏颜色
        //判断是是否是android，是android需去掉AppBar，否则无AnnotatedRegion无效
        child: Theme.of(context).platform == TargetPlatform.android
            ? Container()
            : AppBar(backgroundColor: Colors.white, elevation: 0),
        preferredSize: Size.fromHeight(0),
      ),
      body: shoppingCartList.length > 0
          ? pageBuild()
          : noShoppingCart(context, productList),
    );
  }

  // 购物车页面
  Widget pageBuild() {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: 44,
            padding: EdgeInsets.fromLTRB(16, 9, 16, 9),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "购物车",
                    style: TextStyle(fontSize: 18),
                  ),
                  flex: 1,
                ),
                // 管理或完成 文字
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        managerBtn = this.managerBtn == true ? false : true;
                      });
                    },
                    child: Text(
                      managerBtn == true ? "完成" : "管理",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            child: ListView.separated(
              itemCount: shoppingCartList.length,
              cacheExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  height: 110,
                  child: Row(
                    children: [
                      // 单选框
                      Expanded(
                        child: Checkbox(
                            value: shoppingCartList[index]["select"],
                            onChanged: (value) {
                              setState(() {
                                shoppingCartList[index]["select"] = value;
                                if (value != null) {
                                  checkFunction(
                                      shoppingCartList[index]["id"],
                                      shoppingCartList[index]["product"]
                                          ["price"],
                                      shoppingCartList[index]["productCount"],
                                      value);
                                }
                              });
                            }),
                        flex: 1,
                      ),
                      // 商品图片
                      Expanded(
                        child: Image.network(HttpUtil.httpUrl +
                            shoppingCartList[index]["product"]["images"]),
                        flex: 3,
                      ),
                      // 商品详情
                      Expanded(
                        child: Column(
                          children: [
                            // 商品名称
                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "商品名称:",
                                      style: TextStyle(
                                          color: Color(0xFF443E3F),
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Container(
                                        width: 150,
                                        child: Text(
                                          shoppingCartList[index]["product"]
                                                  ["name"]
                                              .toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xFF443E3F)),
                                        )),
                                  ],
                                ),
                              ),
                              flex: 1,
                            ),
                            // 商品型号
                            Expanded(
                              child: Row(
                                children: [
                                  Text("颜色："),
                                  Text(
                                    "${shoppingCartList[index]["productColor"].toString()}" +
                                        "    ",
                                    style: TextStyle(color: Color(0xFFFA768A)),
                                  ),
                                  Text("尺寸："),
                                  Text(
                                    "${shoppingCartList[index]["productSize"].toString()}",
                                    style: TextStyle(color: Color(0xFFFA768A)),
                                  ),
                                ],
                              ),
                              flex: 2,
                            ),
                            // 商品价格
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "￥" +
                                          shoppingCartList[index]["product"]
                                                  ["price"]
                                              .toString(),
                                      style: TextStyle(
                                          color: Color(0xFFFA768A),
                                          fontSize: 18),
                                    ),
                                    flex: 1,
                                  ),
                                  Container(
                                    child: digitalSelector(index),
                                  ),
                                ],
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                        flex: 6,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.grey);
              },
            ),
          ),
          flex: 10,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                      checkColor: Colors.white,
                      value: selectAllBtn,
                      onChanged: (value) {
                        selectAll(value);
                      }),
                  Text(
                    "全选",
                    style: TextStyle(color: Color(0xFFABA4A5), fontSize: 12),
                  )
                ],
              ),
              Row(
                children: [
                  Opacity(
                    opacity: managerBtn == true ? 0.0 : 1.0,
                    child: Container(
                      child: Text(
                        "合计：",
                        style: TextStyle(
                          color: Color(0xFF443E3F),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: managerBtn == true ? 0.0 : 1.0,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                      width: 80,
                      child: Text(
                        totalPrice.toString(),
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFFFA768A)),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: MaterialButton(
                    height: 35,
                    color: Colors.red,
                    // 结算或删除按钮
                    child: Text(
                      managerBtn == true ? "删除" : "结算",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onPressed: () {
                      settlementFun();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)))),
              ),
            ],
          ),
          flex: 1,
        )
      ],
    );
  }

  // 勾选按钮
  void checkFunction(int id, double price, int count, bool value) {
    if (value == true) {
      ids.add(id);
    } else {
      ids.remove(id);
    }
    // 如果每个复选框都被勾选了 那么点亮全选按钮
    int length = 0;
    shoppingCartList.forEach((cart) {
      if (cart["select"] == true) {
        length++;
      }
    });
    if (length == shoppingCartList.length) {
      selectAllBtn = true;
    } else {
      selectAllBtn = false;
    }

    calcTotalPrice();
    setState(() {});
  }

  // 计算总价格
  void calcTotalPrice() {
    totalPrice = 0.00;
    shoppingCartList.forEach((cart) {
      if (cart['select'] == true) {
        totalPrice += cart["productCount"] * cart["product"]["price"];
      }
    });
  }

  // 数字选择器 布局
  Widget digitalSelector(index) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(
        children: [
          Container(
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.add, color: Color(0xFFA1A9AA)),
              onPressed: () {
                countFun(index, 0);
              },
            ),
          ),
          Container(
            child: Text(shoppingCartList[index]["productCount"].toString()),
          ),
          Container(
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.remove, color: Color(0xFFA1A9AA)),
              onPressed: () {
                countFun(index, 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 数字选择器 函数 index 索引 operator 操作符 0: + 1:-
  countFun(index, operator) {
    // 如果是添加数量
    if (operator == 0) {
      // 如果数量小于99 则能添加
      if (shoppingCartList[index]["productCount"] < 99) {
        shoppingCartList[index]["productCount"]++;
      }
    }
    if (operator == 1) {
      // 如果数量大于1 则不能添加
      if (shoppingCartList[index]["productCount"] > 1) {
        shoppingCartList[index]["productCount"]--;
      }
    }
    calcTotalPrice();
    setState(() {});
  }

  // 底部全选函数
  selectAll(value) {
    // 数组ID重置
    this.ids = [];
    // 总价格重置
    shoppingCartList.forEach((f) {
      f['select'] = value;
      if (value == true) {
        //如果是选中，则将数据ID放入数组
        this.ids.add(f['id']);
      }
    });
    calcTotalPrice();
    selectAllBtn = value;
    setState(() {
      // shoppingCartList = shoppingCartList;
    });
  }

  // 结算按钮
  settlementFun() {
    // 如果是删除
    if (managerBtn == true) {
      // LoggerUtil.info("删除前:" + "${ids}");
      String idsStr = ids.join(",");
      HttpUtil.get("/cart/delete", {"ids": idsStr}, (data) {
        Map<String, dynamic> result = data;
        if (result["code"] == 0) {
          ToastUtil.info(result["msg"]);
          for (var i = 0, len = shoppingCartList.length; i < len; i++) {
            LoggerUtil.info("i:" + "$i");
            for (var j = 0; j < ids.length; j++) {
              if (shoppingCartList[i]["id"] == ids[j]) {
                shoppingCartList.removeAt(i);
                i--;
                len--;
                LoggerUtil.info("删除后" + "$shoppingCartList");
                break;
              }
            }
          }
          getProduct();
          setState(() {});
        } else {
          ToastUtil.error(result["msg"]);
        }
      }, (error) {
        ToastUtil.error("服务器异常");
      });
      // 如果是结算
    } else {
      HttpUtil.get("/order/add/shopping", {
        "shoppingCartIds": ids.join(","),
      }, (data) {
        Map<String, dynamic> result = data;
        if (result["code"] == 0) {
          ToastUtil.info("订单创建成功");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OrderPREPage(id: result["data"].toString(), key: UniqueKey(),)));
        } else {
          ToastUtil.info(result["msg"]);
        }
      }, (error) {});
    }
    // LoggerUtil.info("删除后" + "${shoppingCartList}");
    setState(() {});
    // 如果是结算
  }
}
