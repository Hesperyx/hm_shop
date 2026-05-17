import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  final List<dynamic> data = await dioRequest.get(HttpConstants.BANNER_LIST);
  return data
      .map((item) => BannerItem.fromJSON(item as Map<String, dynamic>))
      .toList();
}

Future<List<CategoryItem>> getCategoryListAPI() async {
  final List<dynamic> data = await dioRequest.get(HttpConstants.CATEGORY_LIST);
  return data
      .map((item) => CategoryItem.fromJSON(item as Map<String, dynamic>))
      .toList();
}

//特惠推荐
Future<RecommendResult> getCategoryRecommendAPI() async {
  final Map<String, dynamic> data = await dioRequest.get(
    HttpConstants.PRODUCT_LIST,
  );
  return RecommendResult.fromJSON(data);
}

// 热榜推荐
Future<RecommendResult> getInVogueListAPI() async {
  // 返回请求
  return RecommendResult.fromJSON(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<RecommendResult> getOneStopListAPI() async {
  // 返回请求
  return RecommendResult.fromJSON(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}
// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}