import 'package:flutter/material.dart';

import 'ButtonEntity.dart';

// 底部栏 按钮组
List<Widget> getBtnGroupsComponent(BuildContext context, List<ButtonEntity> buttonsStr , String orderId) {
  List<Widget> buttons = [];
  buttonsStr.forEach((element) {
    buttons.add(Container(
      margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
      child:  OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(width: 1, color: Color(element.color)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            )),
        child: Text(
          element.name,
          style: TextStyle(fontSize: 12, color: Color(element.color)),
        ),
        onPressed: () {
            element.T();
        },
      ),
    ));
  });


  return buttons;
}
