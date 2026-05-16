class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json["id"], imgUrl: json["imgUrl"] ?? "");
  }
}

//根据json推断编写class对象和工厂转换函数
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  List<dynamic>? goods;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
    this.goods,
  });
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] != null
          ? List<CategoryItem>.from(
              json["children"].map((x) => CategoryItem.fromJson(x)),
            )
          : null,
      goods: json["goods"] != null ? List<dynamic>.from(json["goods"]) : null,
    );
  }
}
