import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:mall/util/HttpUtil.dart';
import 'package:mall/util/ToastUtil.dart';

class ShippingAddressFormPage extends StatefulWidget {
  ShippingAddressFormPage({
    required Key key,
    // 接收一个text参数
    required this.flag,
    required this.dataAddress,
  }) : super(key: key);
  final int flag;
  final Map dataAddress;

  @override
  State<StatefulWidget> createState() {
    return ShippingAddressFormState();
  }
}

class ShippingAddressFormState extends State<ShippingAddressFormPage> {
  var addressEntity = Map();
  bool _switchSelected = true;
  String title = "添加收货地址";

  @override
  void initState() {
    super.initState();
    title = widget.flag == 0 ? "添加收货地址" : "修改收货地址";
    addressEntity = widget.dataAddress;
    // LoggerUtil.info(addressEntity);
    if (addressEntity.length > 0) {
      _usernameController.text = addressEntity["username"].toString();
      _telephoneController.text = addressEntity["telephone"].toString();
      _districtController.text = addressEntity["district"].toString();
      _addressController.text = addressEntity["address"].toString();
      _switchSelected = addressEntity["isDefault"] == 1 ? true : false;
    }
    setState(() {});
  }

  String initProvince = '上海市', initCity = '浦东新区', initTown = '张江镇';
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _telephoneController = new TextEditingController();
  TextEditingController _districtController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
                labelText: "收货人",
                hintText: "用户名或邮箱",
                prefixIcon: Icon(Icons.person)),
          ),
          TextField(
            controller: _telephoneController,
            decoration: InputDecoration(
                labelText: "手机号码",
                hintText: "请填写收货人的手机号",
                prefixIcon: Icon(Icons.phone)),
          ),
          TextField(
            controller: _districtController,
            decoration: InputDecoration(
                hintText: "所在地区", prefixIcon: Icon(Icons.location_on_rounded)),
            onTap: () {
              Pickers.showAddressPicker(
                context,
                initProvince: initProvince,
                initCity: initCity,
                initTown: initTown,
                onConfirm: (p, c, t) {
                  setState(() {
                    _districtController.text = p + c;
                    if (t != null) {
                      _districtController.text = _districtController.text + t;
                    }
                  });
                },
              );
            },
          ),
          TextField(
            controller: _addressController,
            decoration: InputDecoration(
                labelText: "详细地址",
                hintText: "街道、门牌号等",
                prefixIcon: Icon(Icons.location_city)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 70,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "设置成默认地址",
                  style: TextStyle(fontSize: 16),
                )),
                Container(
                  child: Switch(
                    value: _switchSelected, //当前状态
                    onChanged: (value) {
                      //重新构建页面
                      setState(() {
                        _switchSelected = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 70,
          padding: EdgeInsets.fromLTRB(32, 15, 32, 15),
          child: MaterialButton(
              minWidth: 311,
              color: Color(0xFFF9445D),
              child: Text(
                "保存",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                saveBtn();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)))),
        ),
      ),
    );
  }

  void saveBtn() {
    // 如果flag = 0 则代表新建  1 则代表修改
    String uri =
        widget.flag == 0 ? "/shipping/address/add" : "/shipping/address/mod";
    int isDefault = _switchSelected == true ? 1 : 0;
    var params;
    // 添加参数
    params = {
      "username": _usernameController.text,
      "telephone": _telephoneController.text,
      "district": _districtController.text,
      "address": _addressController.text,
      "isDefault": isDefault,
    };
    // 修改参数
    if (widget.flag == 1 && addressEntity.length > 0) {
      params = {
        "username": _usernameController.text,
        "telephone": _telephoneController.text,
        "district": _districtController.text,
        "address": _addressController.text,
        "isDefault": isDefault,
        "id": addressEntity["id"]
      };
    }

    HttpUtil.post(uri, params, (data) {
      Map<String, dynamic> result = data;
      if (result["code"] == 0) {
        ToastUtil.info(result["msg"]);
        Navigator.of(context).pop(widget.flag);
      } else {
        ToastUtil.error(result["msg"]);
      }
    }, (error) {});
  }
}
