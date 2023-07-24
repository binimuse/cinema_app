import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/all_movies.dart';
import '../widgets/app_header.dart';
import '../widgets/app_navigation.dart';

// import 'package:flutter_movies/pages/home/widgets/all_movies.dart';
// import 'package:flutter_movies/pages/home/widgets/app_header.dart';
// import 'package:flutter_movies/pages/home/widgets/app_navigation.dart';
// import 'HomePageController.dart';

class HomeView extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          _controller.updatePosition(details.delta.dx, details.delta.dy);
        },
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Stack(
            children: [
              GetBuilder<HomeController>(
                builder: (_) => AnimatedPositioned(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  top: _.top,
                  left: _.left,
                  child: const AllMovies(),
                ),
              ),
              const AppHeader(),
              const AppNavigation(),
            ],
          ),
        ),
      ),
    );
  }
}
