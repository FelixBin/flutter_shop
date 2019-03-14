import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';//轮播组件
import 'dart:convert';//json
import 'package:flutter_screenutil/flutter_screenutil.dart';//屏幕适配

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('百姓生活+')),
        body: FutureBuilder(
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList =
                  (data['data']['slides'] as List).cast();
              return Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiperDataList),
                ],
              );
            } else {
              return Center(
                child: Text('加载中....'),
              );
            }
          },
        ));
  }
}

//轮播
class SwiperDiy extends StatelessWidget {

  final List swiperDataList;
  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance=ScreenUtil(width: 750,height: 1334)..init(context);//初始化尺寸
    return Container(
      height: ScreenUtil().setHeight(333),//设置尺寸
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDataList[index]['image']}",fit: BoxFit.cover,);
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
