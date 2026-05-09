import 'package:flutter/material.dart';

class HmMortList extends StatefulWidget {
  const HmMortList({super.key});

  @override
  State<HmMortList> createState() => _HmMortListState();
}

class _HmMortListState extends State<HmMortList> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Text("商品", style: TextStyle(color: Colors.white)),
          color: Colors.blue,
          alignment: Alignment.center,
        );
      },
    );
  }
}
