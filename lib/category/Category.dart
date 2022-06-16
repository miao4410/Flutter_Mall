import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mall/search/CategorySearchList.dart';
import 'package:mall/util/HttpUtil.dart';

import '../component/searchTextComponent.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage> {
  final TextEditingController s = new TextEditingController();

  List categoryList = [];

  List _rightCateList = [];
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    EasyLoading.show();

    HttpUtil.get("/category/list", null, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        categoryList = result["data"];
        setState(() {
          _getRightCateData(0);
        });
      }
      EasyLoading.dismiss();
    }, (error) {
      EasyLoading.dismiss();
    });
  }

  //右侧数据：
  _getRightCateData(pid) {
    setState(() {
      if (categoryList[pid]["children"] != null) {
        this._rightCateList = categoryList[pid]["children"];
      } else {
        this._rightCateList = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        //ios下更改状态栏颜色
        //判断是是否是android，是android需去掉AppBar，否则无AnnotatedRegion无效
        child: Theme.of(context).platform == TargetPlatform.android
            ? Container()
            : AppBar(backgroundColor: Colors.white, elevation: 0),
        preferredSize: Size.fromHeight(0),
      ),

      // Column占整个屏幕的高度
      body: new Column(
        children: [
          // 搜索框
          searchTextComponent(context),
          // 分类主体
          Expanded(
            child: Container(
              child: Row(
                children: [
                  // 左侧一级分类
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: ListView.builder(
                          itemCount: categoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _selectIndex = index;
                                  _getRightCateData(_selectIndex);
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 56,
                                child: Text(
                                  categoryList[index]["name"].toString(),
                                ),
                                alignment: Alignment.center,
                                color: _selectIndex == index
                                    ? Colors.white
                                    : Color.fromRGBO(250, 249, 249, 0.9),
                              ),
                            );
                          }),
                    ),
                  ),
                  // 右侧二级分类
                  Expanded(
                      flex: 3,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          height: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 1,
                                      margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                      color: Color(0xFFE6DFE0),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(45, 0, 0, 0),
                                        child: Text("分类",
                                            style: TextStyle(fontSize: 14))),
                                    Container(
                                      width: 32,
                                      height: 1,
                                      margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                      color: Color(0xFFE6DFE0),
                                    ),
                                  ],
                                ),
                                flex: 1,
                              ),
                              Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 0.6,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemCount: _rightCateList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (_rightCateList[index]["id"] !=
                                              null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CategorySearchListPage(
                                                          categoryId:
                                                              _rightCateList[
                                                                  index]["id"],
                                                          categoryName:
                                                              _rightCateList[
                                                                      index]
                                                                  ["name"], key: UniqueKey(),
                                                        )));
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 1,
                                              child: Image.network(HttpUtil
                                                      .httpUrl +
                                                  "${_rightCateList[index]["images"]}"),
                                            ),
                                            Container(
                                              height: 40,
                                              child: Text(
                                                  "${_rightCateList[index]["name"]}"),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                flex: 10,
                              )
                            ],
                          )))
                ],
              ),
            ),
            flex: 14,
          )
        ],
      ),
    );
  }
}
