import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';


//Hanlder是对每个路由的独立配置文件
Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;

  print('index>detail goodsId is ${goodsId}');
  return DetailsPage(goodsId);
});
