import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart'; //轮播组件
import 'dart:convert'; //json
import 'package:flutter_screenutil/flutter_screenutil.dart'; //屏幕适配
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];
//上拉刷新所需key
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
        appBar: AppBar(title: Text('百姓生活+')),
        body: FutureBuilder(
          future: request('homePageContent', formData: formData), //调用接口方法
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

              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast(); // 商品推荐
              String floor1Title =
                  data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              String floor2Title =
                  data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              String floor3Title =
                  data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              List<Map> floor1 =
                  (data['data']['floor1'] as List).cast(); //楼层1商品和图片
              List<Map> floor2 =
                  (data['data']['floor2'] as List).cast(); //楼层1商品和图片
              List<Map> floor3 =
                  (data['data']['floor3'] as List).cast(); //楼层1商品和图片
              return EasyRefresh(
                refreshFooter: ClassicsFooter(
                    key: _footerKey,
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    moreInfoColor: Colors.pink,
                    showMore: true,
                    noMoreText: '',
                    moreInfo: '加载中',
                    loadReadyText: '上拉加载....',
                    ),
                  
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiperDataList),
                    TopNavigator(navigatorList: navigatorList), //导航组件
                    AdBanner(advertesPicture: advertesPicture), //广告组件
                    LeaderPhone(
                        leaderImage: leaderImage,
                        leaderPhone: leaderPhone), //广告组件
                    Recommend(recommendList: recommendList), // 商品推荐
                    FloorTitle(picture_address: floor1Title),
                    FloorContent(floorGoodsList: floor1),
                    FloorTitle(picture_address: floor2Title),
                    FloorContent(floorGoodsList: floor2),
                    FloorTitle(picture_address: floor3Title),
                    FloorContent(floorGoodsList: floor3),
                    _hotGoods()
                  ],
                ),
                loadMore: () async {
                  //上拉刷新回调
                  print('开始加载更多');
                  var formPage = {'page': page};

                  request('homePageBelowConten', formData: formPage)
                      .then((val) {
                    var data = json.decode(val.toString());

                    List<Map> newGoodsList = (data['data'] as List).cast();

                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text('加载中....'),
              );
            }
          },
        ));
  }

//2.火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
    child: Text('火爆专区'),
  );

  //流式布局 接受widget--inkwell

  //3.火爆专区子项
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
            onTap: () {
              print('点击了火爆商品');
            },
            child: Container(
              width: ScreenUtil().setWidth(372),
              color: Colors.white,
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 3.0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    val['image'],
                    width: ScreenUtil().setWidth(375),
                  ),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
            ));
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text(' ');
    }
  }

  //4.火爆专区组合
  Widget _hotGoods() {
    return Container(
        child: Column(
      children: <Widget>[
        hotTitle,
        _wrapList(),
      ],
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
        physics: NeverScrollableScrollPhysics(),
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
        onTap: _launchURL,
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

//推荐商品类的编写
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({Key key, this.recommendList}) : super(key: key);

  //4.在build方法里进行组合
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(468),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommedList()],
      ),
    );
  }

//1.推荐商品标题
  Widget _titleWidget() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text('商品推荐', style: TextStyle(color: Colors.pink)));
  }

  //2.列表组件的编写
  Widget _recommedList() {
    return Container(
      height: ScreenUtil().setHeight(400),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  //3.推荐商品单独项编写
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(
                    width: 1,
                    color: Colors.black12,
                    style: BorderStyle.solid))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image'], fit: BoxFit.cover),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

//首页_楼层区域的编写

//1.编写楼层标题组件
class FloorTitle extends StatelessWidget {
  final String picture_address;
  FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品组件的编写
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  FloorContent({Key key, this.floorGoodsList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

//第一块
  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1]),
            _goodsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

////第二块
  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3]),
        _goodsItem(floorGoodsList[4]),
      ],
    );
  }

  //商品的子项，也算是这个类的最小模块了
  Widget _goodsItem(Map goods_item) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(goods_item['image']),
      ),
    );
  }
}

//火爆专区
class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    super.initState();
    request('homePageBelowConten', formData: 1).then((val) {
      print(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
