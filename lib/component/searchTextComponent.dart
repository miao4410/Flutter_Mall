
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mall/search/HomeSearchList.dart';

Widget searchTextComponent(BuildContext context) {
  TextEditingController s = new TextEditingController();
  return Container(
    color: Colors.white,
    padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
    height: 50.h,
    child: TextField(
      controller: s,
      decoration: new InputDecoration(
        fillColor: Color(0xFF784343),
        isDense: true,
        contentPadding: EdgeInsets.only(),
        prefixIcon: IconButton(iconSize: 24.sp, icon: Icon(Icons.search), onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomeSearchListPage(
                        productName: s.text, key: UniqueKey(),)));
        },),
        // border: InputBorder.none,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // 用来配置边框的样式
          borderSide: BorderSide(
            // 设置边框的颜色
            color: Colors.red.withOpacity(0.6),
            // 设置边框的粗细
            width: 2.w,
          ),
        ),
        hintText: '搜索商品',
        hintStyle: TextStyle(inherit: false, fontSize: 14.sp, color: Colors.black38),
      ),
    ),
  );
}