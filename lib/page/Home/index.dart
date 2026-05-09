import 'package:flutter/widgets.dart';
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
  final List<BannerItem> _bannerList = [
    BannerItem(id: "1", imgUrl: "https://test.fukit.cn/autoupload/fr/ioCV7UKoxek3BrwKzIT-sAX7Oq-q1b6D22ElINzuG0-yl5f0KlZfm6UsKj-HyTuv/20260510/jD8a/4000X2245/%25E3%2580%2590%25E5%2593%25B2%25E9%25A3%258E%25E5%25A3%2581%25E7%25BA%25B8%25E3%2580%2591%25E5%258F%25AF%25E7%2588%25B1%25E5%25B0%258F%25E7%258B%2597-%25E5%25B0%258F%25E7%258B%2597-%25E6%258A%25A4%25E7%259C%25BC.png"),
    BannerItem(id: "2", imgUrl: "https://test.fukit.cn/autoupload/fr/ioCV7UKoxek3BrwKzIT-sAX7Oq-q1b6D22ElINzuG0-yl5f0KlZfm6UsKj-HyTuv/20260510/W5vt/1979X1535/%25E3%2580%2590%25E5%2593%25B2%25E9%25A3%258E%25E5%25A3%2581%25E7%25BA%25B8%25E3%2580%2591%25E5%2586%25AC%25E5%25AD%25A3-%25E5%25A3%2581%25E7%25BA%25B8-%25E5%25A4%259C%25E6%2599%259A.png"),
    BannerItem(id: "3", imgUrl: "https://test.fukit.cn/autoupload/fr/ioCV7UKoxek3BrwKzIT-sAX7Oq-q1b6D22ElINzuG0-yl5f0KlZfm6UsKj-HyTuv/20260510/AXLP/3840X2160/%25E3%2580%2590%25E5%2593%25B2%25E9%25A3%258E%25E5%25A3%2581%25E7%25BA%25B8%25E3%2580%2591%25E4%25BC%2591%25E9%2597%25B2-%25E5%25AE%25A4%25E5%2586%2585-%25E5%25B1%2585%25E5%25AE%25B6.png")
  ];
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList,)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMortList()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
