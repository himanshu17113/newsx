import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/constant/constant.dart';
import 'package:news_app/search/presentation/search.dart';
import 'package:news_app/top_headlines/data/repository/top_headline_service.dart';
import 'package:news_app/top_headlines/presentation/widgets/general_news.dart';
import 'package:news_app/top_headlines/presentation/widgets/headline_card.dart';
import 'constant/pagerouter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _scrollController;
  final ValueNotifier<bool> _isSliverAppBarExpanded = ValueNotifier<bool>(false);
  NewsService newsService = Get.find();
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        _isSliverAppBarExpanded.value = _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
      });
  }

  final ValueNotifier<int> selectedCategories = ValueNotifier<int>(0);

  static const List<String> categories = [
    "All",
    'Business',
    'Entertainment',
    'Technology',
    'General',
    'Sciences',
    'Health',
    'Ports'
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      drawerEnableOpenDragGesture: false,
      key: scaffoldKey,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverSafeArea(
            sliver: SliverAppBar(
              collapsedHeight: context.deviceHeight() * .1,
              titleTextStyle: textTheme.displaySmall,
              stretch: false,
              forceMaterialTransparency: true,
              scrolledUnderElevation: 50,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                titlePadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                expandedTitleScale: 2,
                centerTitle: false,
                background: Container(
                  color: theme.cardColor,
                  alignment: Alignment.centerRight,
                  child: ValueListenableBuilder(
                    valueListenable: _isSliverAppBarExpanded,
                    builder: (BuildContext context, bool value, Widget? child) => value
                        ? ValueListenableBuilder(
                            valueListenable: selectedCategories,
                            builder: (BuildContext context, int value, Widget? child) => ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                                itemCount: categories.length,
                                itemBuilder: (context, index) => Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            selectedCategories.value = index;
                                            newsService.fetchCategory(categories.elementAt(index).toLowerCase());
                                          },
                                          child: Text(categories.elementAt(index),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 16,
                                                shadows: [
                                                  Shadow(color: theme.colorScheme.inverseSurface, offset: const Offset(0, -5))
                                                ],
                                                decorationColor: value == index ? Colors.grey : Colors.transparent,
                                                color: Colors.transparent,
                                                decorationThickness: 2,
                                                decoration: TextDecoration.underline,
                                              )),
                                        ),
                                        const Text("  |  ",
                                            maxLines: 3,
                                            style: TextStyle(
                                              fontSize: 16,
                                              height: 0.6,
                                              color: Colors.grey,
                                              shadows: [Shadow(color: Colors.transparent, offset: Offset(0, -5))],
                                            )),
                                      ],
                                    )),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("  Get the Latest\n  News Updates", style: textTheme.headlineLarge),
                              IconButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    CustomPageRoute(
                                        transitionDuration: const Duration(milliseconds: 700),
                                        child: const SeachScreen(),
                                        begin: const Offset(-1, 0))),
                                icon: const Icon(
                                  Icons.search,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: TopHeadlineCard(),
          ),
          const VerticalNews()
        ],
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate(this._tabBar);

  final Widget _tabBar;

  @override
  double get minExtent => 100;
  @override
  double get maxExtent => 100;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
