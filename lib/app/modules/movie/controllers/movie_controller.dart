import 'package:get/get.dart';

import '../../home/models/movie_model.dart';

class MoviePageController extends GetxController {
  final Rxn<Movie> movie = Rxn<Movie>();

  void setMovie(Movie value) => movie.value = value;
}
