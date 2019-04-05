import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

//路由总体的配置
class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRoutes(Router router) {
    //没有找到页面处理
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
    });

    router.define(detailsPage, handler: detailsHandler);//可以理解为detailsPage这个路径映射到detailsHandler这个处理程序中
  }
}
