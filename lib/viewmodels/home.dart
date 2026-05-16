class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  factory BannerItem.fromJSON(Map<String, dynamic> json) {
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

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
  factory CategoryItem.fromJSON(Map<String, dynamic> json) {
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] != null
          ? List<CategoryItem>.from(
              json["children"].map((x) => CategoryItem.fromJSON(x)),
            )
          : null,
      goods: json["goods"] != null ? List<dynamic>.from(json["goods"]) : null,
    );
  }
}

class RecommendResponse {
  String code;
  String msg;
  RecommendResult result;
  RecommendResponse({
    required this.code,
    required this.msg,
    required this.result,
  });
  factory RecommendResponse.fromJSON(Map<String, dynamic> json) {
    return RecommendResponse(
      code: json["code"] ?? "",
      msg: json["msg"] ?? "",
      result: RecommendResult.fromJSON(json["result"] ?? {}),
    );
  }
}

class RecommendResult {
  String id;
  String title;
  List<SubType> subTypes;
  RecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory RecommendResult.fromJSON(Map<String, dynamic> json) {
    return RecommendResult(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: json["subTypes"] != null
          ? List<SubType>.from(json["subTypes"].map((x) => SubType.fromJSON(x)))
          : [],
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});
  factory SubType.fromJSON(Map<String, dynamic> json) {
    return SubType(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: GoodsItems.fromJSON(json["goodsItems"] ?? {}),
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.fromJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: json["items"] != null
          ? List<GoodsItem>.from(
              json["items"].map((x) => GoodsItem.fromJSON(x)),
            )
          : [],
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.fromJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"],
      price: json["price"] ?? "0.00",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}
