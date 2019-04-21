import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Row(
        children: <Widget>[selectAllBtn(), allPriceArea(), goButton()],
      ),
    );
  }

  //全选按钮

  Widget selectAllBtn() {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            onChanged: (bool val) {},
            value: true,
            activeColor: Colors.pink,
          ),
          Text('全选')
        ],
      ),
    );
  }

  //合计区域方法
  Widget allPriceArea() {
    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text('￥1992',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Colors.red,
                    )),
              )
            ],
          ),
          Container(
            child: Text('满10元免配送费，预购免配送费',
                style: TextStyle(
                    color: Colors.black38, fontSize: ScreenUtil().setSp(22))),
          )
        ],
      ),
    );
  }

  //结算按钮方法
  Widget goButton() {
    return Container(
      width: ScreenUtil().setWidth(150),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
          child: Text('结算(6)', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
