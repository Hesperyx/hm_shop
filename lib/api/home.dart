import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  final List<dynamic> data = await dioRequest.get(HttpConstants.BANNER_LIST);
  return data
      .map((item) => BannerItem.formJOSN(item as Map<String, dynamic>))
      .toList();
}

Future<List<CategoryItem>> getCategoryListAPI() async {
  final List<dynamic> data = await dioRequest.get(HttpConstants.CATEGORY_LIST);
  return data
      .map((item) => CategoryItem.formJOSN(item as Map<String, dynamic>))
      .toList();
}

//特惠推荐
Future<RecommendResult> getCategoryRecommendAPI() async {
  final Map<String, dynamic> data = await dioRequest.get(
    HttpConstants.PRODUCT_LIST,
  );
  return RecommendResult.formJOSN(data);
}
