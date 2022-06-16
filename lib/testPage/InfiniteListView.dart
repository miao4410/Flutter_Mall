import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InfiniteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnlyGridViewState();
  }
}

class _OnlyGridViewState extends State<InfiniteListView> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<String> data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  Widget buildCtn() {
    return GridView.builder(
      physics: ClampingScrollPhysics(),
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: data.length,
        itemBuilder: (context, index) {
        return Text("${data[index]}");
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: [
          Text("sdssadasdsa"),
          Expanded(child: SmartRefresher(
            controller: _refreshController,
            enablePullUp: true,
            enablePullDown: false,
            child: buildCtn(),
            header: ClassicHeader(),

            onLoading: () async {
              //monitor fetch data from network
              await Future.delayed(Duration(milliseconds: 1000));
              for (int i = 0; i < 10; i++) {
                data.add("Item $i");
              }
//    pageIndex++;
              if (mounted) setState(() {});
              _refreshController.loadComplete();
            },
          ))
        ],
      ),
    );
  }
}