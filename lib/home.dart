import 'package:flutter/material.dart';
import 'package:news_app/constant/constant.dart';
import 'package:news_app/search/presentation/search.dart';
import 'package:news_app/top_headlines/presentation/widgets/general_news.dart';
import 'package:news_app/top_headlines/presentation/widgets/headline_card.dart';
import 'constant/pagerouter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        slivers: [
          SliverAppBar(
            collapsedHeight: context.deviceHeight() * .12,
            titleTextStyle: textTheme.displaySmall,
            toolbarHeight: context.deviceHeight() * .02,
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
                // decoration: const BoxDecoration(
                //     gradient: LinearGradient(colors: [
                //   Color(0xFFF0E1F7),
                //   Color(0xFFD6DFFC),
                // ])),
                //color: theme.scaffoldBackgroundColor,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(top: 50, right: 20, bottom: 0),
                child: Row(
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
          const SliverToBoxAdapter(
            child: TopHeadlineCard(),
          ),
          const VerticalNews()
        ],
      ),
    );
  }
}
