import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import './provide/currentIndex.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var currentIndexProvide=CurrentIndexProvide();
  var cartProvide = CartProvide();

  var providers = Providers()
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
     ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<CartProvide>.value(cartProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //路由注册
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router; //路由静态化

    return Container(
      child: MaterialApp(
          title: '百姓生活+',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator, //将路由与app关联到一起（绑定到app上）
          theme: ThemeData(primaryColor: Colors.pink),
          home: IndexPage()),
    );
  }
}
