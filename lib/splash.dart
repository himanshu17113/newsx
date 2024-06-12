import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/constant/constant.dart';
import 'package:news_app/search/service/search_controller_service.dart';
import 'package:news_app/top_headlines/data/repository/top_headline_service.dart';
import 'constant/pagerouter.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  int count = 0;
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    
    Get.lazyPut<SearchxController>(() => SearchxController());
    Get.put(NewsService(), permanent: true);
    _lottieController = AnimationController(vsync: this);
    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _lottieController.reverse();
      }
    });
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          CustomPageRoute(
              transitionDuration: const Duration(milliseconds: 420), child: const Home(), begin: const Offset(-1, 0)));
    });
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.deviceHeight() / 2,
            child: Lottie.asset(
              'assets/lottie/news.json',
              fit: BoxFit.cover,
              width: context.deviceWidth(),
              controller: _lottieController,
              onLoaded: (composition) {
                _lottieController
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
          const Text(
            "Get the News That Matters!",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          )
        ],
      ),
    );
  }
}
