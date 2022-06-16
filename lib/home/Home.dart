import 'package:flutter/material.dart';
import 'package:mall/product/Product.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../component/searchTextComponent.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
// 4.初始化并调用接口

}

class HomePageState extends State<HomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List productList = [];

  // 请求第几页数据，用于分页请求数据
  int pageNum = 1;

  @override
  void initState() {
    productList.clear();
    super.initState();
    _retrieveData();
  }

  // 请求数据
  _retrieveData() {
    HttpUtil.get("/product/list", {"pageNum": pageNum}, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        List resultList = result["data"];
        productList.addAll(resultList);
        pageNum++;
        // 若此对象仍在部件树中才能调用setdata  否则在加载中突然切换其它页面则会报错 
        if(mounted) {
          setState(() {});
        } 
        _refreshController.loadComplete();
      }
    }, (error) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        appBar: PreferredSize(
          // ios下更改状态栏颜色
          // 判断是是否是android，是android需去掉AppBar，否则无AnnotatedRegion无效
          child: Theme.of(context).platform == TargetPlatform.android
              ? Container()
              : AppBar(backgroundColor: Colors.white, elevation: 0),
          preferredSize: Size.fromHeight(0),
        ),
        body: new Column(
          children: [
            //  搜索框
            searchTextComponent(context),
            //  轮播图
            Container(
              margin: EdgeInsets.fromLTRB(20, 8, 20, 0),
              height: 138,
              decoration: new BoxDecoration(
                color: Color(0xE9E9E9E9),
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
            //  新品推荐
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              height: 44,
              child: Row(
                children: [
                  Expanded(child: Text("新品推荐")),
                  Expanded(
                      child: Text(
                    "更多",
                    textAlign: TextAlign.right,
                  ))
                ],
              ),
            ),
            //  商品列表
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: true,
                    enablePullDown: false,
                    header: ClassicHeader(),
                    child: GridView.builder(
                        physics: ClampingScrollPhysics(),
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
                                        builder: (context) => ProductPage(
                                            id: productList[index]["id"], key: UniqueKey(),)));
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
                                          HttpUtil.httpUrl +
                                              productList[index]["images"],
                                        )),
                                  ),
                                  //  图片加载 因FadeInImage会把圆角覆盖 暂时不用
                                  /*child: FadeInImage.memoryNetwork(
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
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 0, 2, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text("会员价",
                                                  style: TextStyle(
                                                      color: Colors.pinkAccent),
                                                  textAlign: TextAlign.left),
                                            ),
                                            Expanded(
                                              child: Text("原价",
                                                  style: TextStyle(
                                                      color: Colors.black26),
                                                  textAlign: TextAlign.right),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(0, 5)),
                                          ),
                                          margin:
                                              EdgeInsets.fromLTRB(0, 1, 0, 0),
                                          padding:
                                              EdgeInsets.fromLTRB(2, 0, 2, 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                productList[index]["price"]
                                                    .toString(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.pinkAccent,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Expanded(
                                                  child: Text(
                                                productList[index]["oldPrice"]
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.black26,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                    onLoading: () async {
                      await Future.delayed(Duration(milliseconds: 1000));
                      _retrieveData();
                    },
                  )),
            ),
          ],
        ));
  }

  List<String> imageList = [
    HttpUtil.httpUrl + "/file/mall/1627538041.jpg",
    HttpUtil.httpUrl + "/file/mall/1627538041.jpg",
    HttpUtil.httpUrl + "/file/mall/1627538041.jpg",
    HttpUtil.httpUrl + "/file/mall/1627538041.jpg",
  ];

  builderBannerWidget() {
    return PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        return buildPageViewItemWidget(index);
      },
      itemCount: imageList.length,
    );
  }

  buildTipWidget() {
    return Container();
  }

  buildPageViewItemWidget(int index) {
    return Image.network(imageList[index], fit: BoxFit.fill);
  }
}
