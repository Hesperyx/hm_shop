import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmMortList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/components/Home/Hmhot.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
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
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    print("开始获取推荐列表，page: $_page");
    List<GoodDetailItem> newList = await getRecommendListAPI({"limit": 8});
    print("推荐列表返回: ${newList.length} 条数据");
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
  Future<void> _getInVogueList() async {
    print("开始获取热榜推荐");
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    print("开始获取一站式推荐");
    _oneStopResult = await getOneStopListAPI();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerEvent();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _key.currentState?.show();
    });
  }

  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        _getRecommendList();
        Future.microtask(() {
          _paddingTop = 100;
          setState(() {});
          _key.currentState?.show();
        });
      }
    });
  }

  // 注册事件
  Future<void> _getCategoryRecommend() async {
    print("开始获取特惠推荐");
    _recommendResult = await getCategoryRecommendAPI();
  }

  Future<void> _getBannerList() async {
    print("开始获取轮播图");
    _bannerList = await getBannerListAPI();
    print("轮播图返回: ${_bannerList.length} 条数据");
  }

  Future<void> _getCategoryList() async {
    print("开始获取分类列表");
    _categoryList = await getCategoryListAPI();
    print("分类返回: ${_categoryList.length} 条数据");
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    _recommendList.clear();
    await _getBannerList();
    await _getCategoryList();
    await _getCategoryRecommend();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    Toastutils.showToast(context, "下拉刷新完成");
    _paddingTop = 0;
    setState(() {});
  }

  final ScrollController _controller = ScrollController();
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
