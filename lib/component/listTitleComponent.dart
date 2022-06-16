import 'package:flutter/material.dart';
import 'package:mall/util/ToastUtil.dart';

/// 标题列表 [title] 标题 [widget] 点击触发的方法
Widget listTitleComponent(BuildContext context, String title, Widget? widget) {
  return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            trailing: Icon(Icons.keyboard_arrow_right),
            hoverColor: Colors.blue,
            focusColor: Colors.red,
            onTap: () {
              if (widget != null) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => widget));
              } else {
                ToastUtil.error("此功能暂未开发");
              }
            },
          ),
          Divider(
            height: 0.5,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
        ],
      ));
}

Widget listSubTitleComponent(
    BuildContext context, String title, String subtitle, Widget? widget) {
  return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Icon(Icons.keyboard_arrow_right),
            hoverColor: Colors.blue,
            focusColor: Colors.red,
            onTap: () {
              if (widget != null) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => widget));
              } else {
                ToastUtil.error("此功能暂未开发");
              }
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
        ],
      ));
}
