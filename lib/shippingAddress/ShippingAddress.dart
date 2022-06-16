import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mall/util/HttpUtil.dart';

import 'ShippingAddressForm.dart';

class ShippingAddressPage extends StatefulWidget {
  ShippingAddressPage({
    required Key key,
    // fromType "order"订单页  "person"个人页
    required this.fromType,
  }) : super(key: key);
  final String fromType;

  @override
  State<StatefulWidget> createState() {
    return ShippingAddressState();
  }
}

class ShippingAddressState extends State<ShippingAddressPage> {
  List shippingAddressList = [];
  String fromType = "";
  @override
  void initState() {
    fromType = widget.fromType;
    super.initState();
    getData();
  }

  void getData() {
    EasyLoading.show();
    HttpUtil.get("/shipping/address/list", null, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        shippingAddressList = result["data"];
        setState(() {});
      }
      EasyLoading.dismiss();
    }, (error) {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: shippingAddressList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 50,
                            child: Text(
                              shippingAddressList[index]["username"].toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                            child: Text(
                              shippingAddressList[index]["telephone"]
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                              child: Opacity(
                                  opacity: shippingAddressList[index]
                                              ["isDefault"] ==
                                          1
                                      ? 1.00
                                      : 0.00,
                                  child: Chip(
                                    label: Text("默认"),
                                    backgroundColor: Color(0xFFF9445D),
                                  )))
                        ],
                      ),
                      subtitle: Text(shippingAddressList[index]
                              ["districtAndAddress"]
                          .toString()),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      hoverColor: Colors.blue,
                      focusColor: Colors.red,
                      onTap: () {
                        // 如果是从订单页面过来的
                        if (fromType == "order") {
                          Navigator.of(context).pop(shippingAddressList[index]);
                        } else {
                          goToShippingAddressForm(
                              context, 1, shippingAddressList[index]);
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
          }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 70,
          padding: EdgeInsets.fromLTRB(32, 15, 32, 15),
          child: MaterialButton(
              minWidth: 311,
              color: Color(0xFFF9445D),
              child: Text(
                "新建收货地址",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                goToShippingAddressForm(context, 0, {});
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)))),
        ),
      ),
    );
  }

  void goToShippingAddressForm(BuildContext context, int flag, var data) {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ShippingAddressFormPage(flag: flag, dataAddress: data, key: UniqueKey(),)))
        .then((value) => {
              getData(),
            });
  }
}
