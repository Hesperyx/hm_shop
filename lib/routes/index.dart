import 'package:flutter/material.dart';
import 'package:hm_shop/page/Login/index.dart';
import 'package:hm_shop/page/Main/index.dart';

//返回APP根级组件
Widget getRootWidget(){
  return MaterialApp(
    //命名路由
    initialRoute: "/",
    routes:getRoutes()
  );
}
// 返回该APP的路由配置
Map<String, Widget Function(BuildContext)> getRoutes(){
  return { 
    '/':(context)=>MainPage(),//主页
    'login':(context)=>LoginPage(),//登录
  };
}