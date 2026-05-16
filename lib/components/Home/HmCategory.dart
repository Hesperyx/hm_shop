import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  final List<CategoryItem> categoryList;
  const HmCategory({super.key, required this.categoryList});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    if (widget.categoryList.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(height: 100, child: Center(child: Text('暂无分类数据'))),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: widget.categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            final CategoryItem item = widget.categoryList[index];
            return Container(
              alignment: Alignment.center,
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 235, 236),
                borderRadius: BorderRadius.circular(40),
              ),
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    item.picture,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.category, size: 50, color: Colors.grey);
                    },
                  ),
                  SizedBox(height: 5),
                  Text(
                    item.name,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
