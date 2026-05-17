import 'package:flutter/widgets.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmMortList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/Hmhot.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CategoryItem> _categoryList = [];
  List<BannerItem> _bannerList = [
    // BannerItem(id: "1", imgUrl: "https://imgs.catoi.cn/v2/HqcXGGX.jpeg"),
    // BannerItem(id: "2", imgUrl: "https://imgs.catoi.cn/v2/qgTdBMV.jpeg"),
    // BannerItem(id: "3", imgUrl: "https://imgs.catoi.cn/v2/yoxlaeN.jpeg")
  ];
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: HmSuggestion(recommendResult: _recommendResult),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  RecommendResult _recommendResult = RecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 热榜推荐
  RecommendResult _inVogueResult = RecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  RecommendResult _oneStopResult = RecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  List<GoodDetailItem> _recommendList = [];

  // 获取推荐列表
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  void _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int requestList = _page * 8;
    List<GoodDetailItem> newList = await getRecommendListAPI({
      "limit": requestList,
    });
    _isLoading = false;

    if (newList.isEmpty) {
      _hasMore = false;
      return;
    }
    _page++;
    _recommendList.addAll(newList);
    setState(() {});
    if (newList.length < 8) {
      _hasMore = false;
    }
  }

  // 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getCategoryRecommend();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
    _registerEvent();
  }

  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        _getRecommendList();
      }
    });
  }

  // 注册事件
  void _getCategoryRecommend() async {
    _recommendResult = await getCategoryRecommendAPI();
    setState(() {});
  }

  void _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: _getScrollChildren(),
    );
  }
}
