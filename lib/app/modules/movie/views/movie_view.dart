import 'package:cinema_app/app/modules/home/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_chip.dart';
import '../../../widgets/glass_icon_button.dart';
import '../../../widgets/scaleup_animation.dart';
import '../../../widgets/translateup_animation.dart';
import '../../book_ticket/views/book_ticket_view.dart';
import '../../ticket/views/ticket_view.dart';
import '../controllers/movie_controller.dart';
// import 'path_to_file_with_movie_class/movie.dart'; // replace with your import
// import 'MoviePageController.dart';

class MovieView extends StatelessWidget {
  const MovieView({Key? key, this.movie}) : super(key: key);

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoviePageController>(
      init: MoviePageController(),
      builder: (controller) => MoviepageView(
        movie: movie!,
        key: null,
      ),
    );
  }
}

class MoviepageView extends StatelessWidget {
  MoviepageView({Key? key, required this.movie}) : super(key: key);

  final Movie movie;
  final MoviePageController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    _controller.setMovie(movie); // set your movie instance here

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        // Obx will listen for changes in any observable used inside it
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Hero(
                tag: _controller.movie.value!.name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    _controller.movie.value!.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScaleUpAnimation(
                        child: GlassIconButton(
                          onTap: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const ScaleUpAnimation(
                        child: GlassIconButton(
                            icon: Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        )),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TranslateUpAnimation(
                            child: Text(
                              _controller.movie.value!.name,
                              style: const TextStyle(
                                shadows: [
                                  Shadow(
                                    color: Colors.black54,
                                    offset: Offset(0, 1),
                                    blurRadius: 10,
                                  ),
                                ],
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TranslateUpAnimation(
                            duration: const Duration(milliseconds: 2000),
                            child: _getMovieChips(),
                          ),
                          const SizedBox(height: 15),
                          TranslateUpAnimation(
                            duration: const Duration(milliseconds: 2400),
                            child: ElevatedButton(
                              onPressed: () => _bookTicket(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                              ),
                              child: const Text(
                                'Book ticket',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _bookTicket(BuildContext context) {
    Navigator.of(context)
        .push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1800),
        reverseTransitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, _) {
          const begin = Offset(0, 1);
          const end = Offset.zero;
          const curve = Curves.fastLinearToSlowEaseIn;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: BookTicketPage(
              movie: _controller.movie.value,
              key: null,
            ),
          );
        },
      ),
    )
        .then((value) async {
      if (value != null) {
        await Future.delayed(const Duration(milliseconds: 500));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: ((context, animation, secondaryAnimation) =>
                FadeTransition(
                  opacity: animation,
                  child: TicketPage(
                    movie: _controller.movie.value,
                  ),
                )),
          ),
        );
      }
    });
  }

  Row _getMovieChips() {
    return Row(
      children: [
        AppChip(
          text: 'IMDB 8.1',
          color: Colors.yellow,
          textColor: Colors.black,
        ),
        const SizedBox(width: 9),
        AppChip(text: 'Crime'),
        const SizedBox(width: 9),
        AppChip(text: 'Horror'),
      ],
    );
  }
}
