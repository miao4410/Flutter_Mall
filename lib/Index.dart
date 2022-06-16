import 'package:flutter/material.dart';
import 'package:mall/home/Home.dart';
import 'package:mall/category/Category.dart';
import 'package:mall/shoppingCart/ShoppingCart.dart';

import 'person/Person.dart';
class IndexPage extends StatefulWidget {
  IndexPage({required Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyStatefulWidgetState();
  }

}



// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<IndexPage> {

  int _selectedIndex = 0;
  final pages = [HomePage(), CategoryPage(), ShoppingCartPage(), PersonPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    /*  appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),*/
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: '分类',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '购物车',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
            backgroundColor: Colors.pink,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}