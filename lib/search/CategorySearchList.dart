import 'package:flutter/material.dart';
import 'package:mall/component/myAppBarComponent.dart';
import 'package:mall/product/ProductListCompoent.dart';
import 'package:mall/search/SearchListNull.dart';
import 'package:mall/util/HttpUtil.dart';

class CategorySearchListPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  CategorySearchListPage({
    required Key key,
    // 接收一个text参数
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategorySearchListState();
  }
// 4.初始化并调用接口

}

class CategorySearchListState extends State<CategorySearchListPage> {
  final TextEditingController s = new TextEditingController();

  List productList = [];
  String categoryName = "";

  @override
  void initState() {
    super.initState();
    int categoryId = widget.categoryId;
    categoryName = widget.categoryName;
    HttpUtil.get("/product/list", {"categoryId": categoryId}, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        productList = result["data"];
        setState(() {});
      }
    }, (error) {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: myAppBarComponent(context, categoryName),
        body: productList.length <= 0
            ? getSearchListNull()
            : new Column(
                children: [
                  Expanded(child: productListComponent(context, productList)),
                ],
              ));
  }
}
