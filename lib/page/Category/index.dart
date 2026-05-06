import 'package:flutter/material.dart';

class CateView extends StatefulWidget {
  const CateView({super.key});

  @override
  State<CateView> createState() => _CateViewState();
}

class _CateViewState extends State<CateView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("分类组件"),
    );
  }
}