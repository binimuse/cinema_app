import 'dart:math';

import 'package:cinema_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cubit/movies_cubit.dart';
import '../../ticket/views/ticket_view.dart';

class BookTicketController extends GetxController {
  final state = MoviesState().obs;

  var selected = <int>[].obs;

  Future<void> loadSeats() async {
    int seats = 35;
    selected.clear();
    state.value = MoviesState(status: MoviesStatus.loading, seats: seats);

    await Future.delayed(const Duration(seconds: 1));

    final busy = <int>[];
    for (var i = 0; i < 15; i++) {
      final x = Random().nextInt(seats);
      busy.add(x);
    }

    state.value = MoviesState(
      status: MoviesStatus.loaded,
      seats: seats,
      empty: [0, 6],
      selected: selected,
      busy: busy,
    );
  }

  Future<void> select(int index) async {
    if (selected.contains(index)) {
      selected.remove(index);
    } else {
      selected.add(index);
    }

    state.value = state.value.copyWith(selected: selected);
  }

  Future<void> book(BuildContext context, movie) async {
    state.value = state.value.copyWith(status: MoviesStatus.booked);
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) =>
            FadeTransition(
              opacity: animation,
              child: TicketPage(
                movie: movie,
              ),
            )),
      ),
    );
  }

  var columns = 7;

  MoviesState getState() {
    return state.value;
  }

  SeatStatus getStatus(int index) {
    if (state.value.empty.contains(index)) {
      return SeatStatus.empty;
    }
    if (state.value.selected.contains(index)) {
      return SeatStatus.selected;
    }
    if (state.value.busy.contains(index)) {
      return SeatStatus.busy;
    }
    return SeatStatus.free;
  }
}

enum SeatStatus { empty, free, busy, selected }
