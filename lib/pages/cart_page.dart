import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testlist = [];

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 400.0,
            child: ListView.builder(
              itemCount: testlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testlist[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: (){
              _add();
            },
          child: Text('增加'),
          ),
          RaisedButton(
            onPressed: (){
              _clear();
            },
          child: Text('清空'),
          )
        ],
      ),
    );
  }

  void _add() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    String temp = "你说的发送到你发了多少烦恼";
    testlist.add(temp);
    pres.setStringList("testlist", testlist);
    _show();
  }

  void _show() async {
    SharedPreferences pres = await SharedPreferences.getInstance();

    if (pres.getStringList('testlist') != null) {
      setState(() {
        testlist = pres.getStringList('testlist');
      });
    }
  }

  void _clear() async {
    SharedPreferences pres = await SharedPreferences.getInstance();

    if (pres.getStringList('testlist') != null) {
      pres.clear();
      setState(() {
        testlist = [];
      });
    }
  }
}
