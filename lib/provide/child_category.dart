import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  String categoryId = '4'; //大类Id
  int childIndex = 0; //子类高亮索引
  String subId = ''; //子类Id

//大类切换逻辑
  getChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id; //大类id
    childIndex = 0;
    subId = ''; //点击大类时，把子类ID清空
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  //传递两个参数，使用新传递的参数给状态赋值
  changeChildIndex(index, String id) {
    subId = id; //点击子类时记录子类id
    childIndex = index;
    notifyListeners();
  }
}
