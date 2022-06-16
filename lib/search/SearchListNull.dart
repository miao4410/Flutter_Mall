import 'package:flutter/cupertino.dart';

Widget getSearchListNull() {
  return Center(
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 220, 0, 0),
          child: Image(
              image: AssetImage("assets/images/search/img_search_empty.png")),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 36, 0, 0),
          child: Text(
            "没有找内容",
            style: TextStyle(fontSize: 18, color: Color(0xFF443E3F)),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
          child: Text(
            "请尝试重新搜索",
            style: TextStyle(fontSize: 14, color: Color(0xFFABA4A5)),
          ),
        ),
      ],
    ),
  );
}
