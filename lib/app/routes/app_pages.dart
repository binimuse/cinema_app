import 'package:get/get.dart';

import '../modules/book_ticket/bindings/book_ticket_binding.dart';
import '../modules/book_ticket/views/book_ticket_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/movie/bindings/movie_binding.dart';
import '../modules/movie/views/movie_view.dart';
import '../modules/ticket/bindings/ticket_binding.dart';
import '../modules/ticket/views/ticket_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE,
      page: () => MovieView(),
      binding: MovieBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_TICKET,
      page: () => BookTicketView(),
      binding: BookTicketBinding(),
    ),
    GetPage(
      name: _Paths.TICKET,
      page: () => const TicketPage(),
      binding: TicketBinding(),
    ),
  ];
}
