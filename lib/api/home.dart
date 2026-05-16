import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  final List<dynamic> data = await dioRequest.get(HttpConstants.BANNER_LIST);
  return data
      .map((item) => BannerItem.fromJson(item as Map<String, dynamic>))
      .toList();
}

Future<List<CategoryItem>> getCategoryListAPI() async {
  final List<dynamic> data = await dioRequest.get(HttpConstants.CATEGORY_LIST);
  return data
      .map((item) => CategoryItem.fromJson(item as Map<String, dynamic>))
      .toList();
}
