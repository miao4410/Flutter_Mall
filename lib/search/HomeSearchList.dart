import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall/product/ProductListCompoent.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:mall/util/LoggerUtil.dart';

import 'SearchListNull.dart';

class HomeSearchListPage extends StatefulWidget {
  final String productName;

  HomeSearchListPage({
    required Key key,
    // 接收一个text参数
    required this.productName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeSearchListState();
  }
// 4.初始化并调用接口

}

class HomeSearchListState extends State<HomeSearchListPage> {
  final TextEditingController s = new TextEditingController();

  List productList = [];
  String productName = "";

  @override
  void initState() {
    super.initState();
    productName = widget.productName;
    LoggerUtil.info("productName" + "$productName");
    HttpUtil.get("/product/list", {"s": productName}, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        if (mounted) {
          setState(() {
            productList = result["data"];
          });
        }
      }
    }, (error) {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // 处理键盘弹框引起的布局
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          // ios下更改状态栏颜色
          //判断是是否是android，是android需去掉AppBar，否则无AnnotatedRegion无效
          child: Theme.of(context).platform == TargetPlatform.android
              ? Container()
              : AppBar(backgroundColor: Colors.white, elevation: 0),
          preferredSize: Size.fromHeight(0),
        ),
        body: new Column(
          children: [
            Container(
                height: 50.h,
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
                child: Row(
                  children: [
                    Container(
                        width: 40.w,
                        child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            })),
                    Container(
                        width: 319.w,
                        child: TextField(
                          controller: s,
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(),
                            prefixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                HttpUtil.get("/product/list", {"s": s.text},
                                    (data) {
                                  Map<String, dynamic> result = data;
                                  if (result["code"] == 0) {
                                    if (mounted) {
                                      setState(() {
                                        productList = result["data"];
                                      });
                                    }
                                  }
                                }, (error) {});
                              },
                            ),
                            // border: InputBorder.none,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              // 用来配置边框的样式
                              borderSide: BorderSide(
                                // 设置边框的颜色
                                color: Colors.red.withOpacity(0.6),
                                // 设置边框的粗细
                                width: 2.0,
                              ),
                            ),
                            hintText: '搜索商品',
                            hintStyle: TextStyle(
                                inherit: false, color: Colors.black38),
                          ),
                        ))
                  ],
                )),
            Expanded(
                child: productList.length <= 0
                    ? getSearchListNull()
                    : productListComponent(context, productList))
          ],
        ));
  }
}
