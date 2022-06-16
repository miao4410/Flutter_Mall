
import 'package:flutter/material.dart';
import 'package:mall/component/myAppBarComponent.dart';

class UserServerProtocolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: myAppBarComponent(context, "用户服务协议"),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.fromLTRB(17, 8, 16, 8),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                alignment: Alignment.centerLeft,
                child: Text("标题", style: TextStyle(color: Color(0xFF443E3F), fontSize: 18, fontWeight: FontWeight.w500),),
              ),

              Container(
                child: Text("在文字录入比赛（打字比赛）中，最公平的比赛用文本就是随机文本，这个随机汉字生成器便是为此所作。普通人的汉字录入速度一般是每分钟几十个到一百多个，我们可以生成一两千字的随机汉字文本，让比赛者录入完这些汉字，依据他们的比赛用时和正确率判断名次。生成随机汉字的原始文字一般选择常用汉字，经过随机排列之后只能一个字一个字的输入，对参赛者来说是相对公平的方案。在文字录入比赛（打字比赛）中，最公平的比赛用文本就是随机文本，这个随机汉字生成器便是为此所作。",
                  style: TextStyle(color: Color(0xFF443E3F), fontSize: 14),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 16, 0, 8),
                alignment: Alignment.centerLeft,
                child: Text("标题", style: TextStyle(color: Color(0xFF443E3F), fontSize: 18, fontWeight: FontWeight.w500),),
              ),

              Container(
                child: Text("普通文本加粗普通文本加粗普通文本加粗普通文本加粗普通文本加粗",
                  style: TextStyle(color: Color(0xFF443E3F), fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),






            ],
          ),

        ),
      ),
    );
  }

}