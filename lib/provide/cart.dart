import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];

  //商品添加到购物车
  save(goodsId, goodsName, count, price, images) async {
    //初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //获取持久化存储的值
    cartString = prefs.getString('cartInfo');

    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    //如果有值进行decode操作
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    //把获得值(字符串)转变成List
    List<Map> tempList = (temp as List).cast();

    //声明变量，用于判断购物车中是否已经存在此商品ID
    //默认为没有
    var isHave = false;

    //用于进行循环的索引使用
    int ival = 0;

    //进行循环，找出是否已经存在该商品
    //如果存在，数量进行+1操作
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      } else {
        ival++;
      }
    });

//  如果没有，进行增加
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      };

      tempList.add(newGoods);
      cartList.add(new CartInfoModel.fromJson(newGoods));
    }

    //把字符串进行encode操作，

    cartString = json.encode(tempList).toString();
    // print(cartString);
    //进行持久化
    prefs.setString('cartInfo', cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();//清空键值对
    // prefs.remove('cartInfo');

    print('清空完成-----------------');
    notifyListeners();
  }

  //得到购物车中的商品
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    cartString = prefs.getString('cartInfo');
    cartList = [];

    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        cartList.add(new CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }
}
