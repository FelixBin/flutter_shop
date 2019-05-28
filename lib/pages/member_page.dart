import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[_topHeader(), _orderTitle(), _orderType(),_actionList()],
      ),
    );
  }

//顶部头像区域
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network(
                  'https://upload.jianshu.io/users/upload_avatars/7979924/80dff0e8-355c-448a-bbd5-fb12e576ed16.png?imageMogr2/auto-orient/strip|imageView2/1/w/120/h/120'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'wfaceboss',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

//会员中心_订单区域
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

//订单列表区域

  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.party_mode,
                    size: 30,
                  ),
                  Text('代付款')
                ],
              )),
          Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.query_builder,
                    size: 30,
                  ),
                  Text('代发货')
                ],
              )),
          Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.directions_car,
                    size: 30,
                  ),
                  Text('待收货')
                ],
              )),
          Container(
              width: ScreenUtil().setWidth(187),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.content_paste,
                    size: 30,
                  ),
                  Text('待评价')
                ],
              ))
        ],
      ),
    );
  }

//下底部区域-公共部分

  Widget _myListTile(String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('客服电话'),
          _myListTile('关于我们'),
        ],
      ),
    );
  }
}
