import 'package:flutter/material.dart';
import '../provide/details_info.dart';
import 'package:provide/provide.dart';
import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/details_content.dart';
import './details_page/details_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print("返回上一页");
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                     // DetailsContent(),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Text('加载中.....'),
            );
          }
        },
      ),
    );
  }

//发送请求
  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    print('加载完成............');
    return '完成加载';
  }
}
