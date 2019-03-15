import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart'; //轮播组件
import 'dart:convert'; //json
import 'package:flutter_screenutil/flutter_screenutil.dart'; //屏幕适配
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('百姓生活+')),
        body: FutureBuilder(
          future: getHomePageContent(), //调用接口方法
          builder: (context, snapshot) {
            //数据处理
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList =
                  (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast(); //类别列表
              String advertesPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];

              String leaderImage =
                  data['data']['shopInfo']['leaderImage']; //店长图片
              String leaderPhone =
                  data['data']['shopInfo']['leaderPhone']; //店长电话
              return SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  SwiperDiy(swiperDataList: swiperDataList),
                  TopNavigator(navigatorList: navigatorList), //导航组件
                  AdBanner(advertesPicture: advertesPicture), //广告组件
                  LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone), //广告组件
                ],
              ));
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
    return Container(
      height: ScreenUtil().setHeight(333), //设置尺寸
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.cover,
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//首页导航(单组件)
class TopNavigator extends StatelessWidget {
  //这个类被调用时会传递一个list过来
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 0) {
      navigatorList.removeRange(
          10, navigatorList.length); // navigatorList.removeLast();
    }
    return Container(
      height: ScreenUtil().setHeight(348),
      padding: const EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: const EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item); //每一个列表项
        }).toList(),
      ),
    );
  }

//上图下文结构
  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      //路由跳转
      onTap: () {
        print('导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
}

//广告图片
class AdBanner extends StatelessWidget {
  final String advertesPicture;
  AdBanner({Key key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}

//店长电话

class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; //店长电话

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap:_launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('url不能访问，异常!');
    }
  }
}
