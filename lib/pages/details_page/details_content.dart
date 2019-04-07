import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<DetailsInfoProvide>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail; //商品详情
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10),
            child: Text(
              '暂无评论信息',
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
            ),
          );
        }
      },
    );
  }
}
