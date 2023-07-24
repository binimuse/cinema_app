import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/glass_icon_button.dart';
import '../../../widgets/scaleup_animation.dart';
import '../../home/models/movie_model.dart';
import '../controllers/book_ticket_controller.dart';
import '../widgets/day_selector.dart';
import '../widgets/screen.dart';
import '../widgets/seat_selector.dart';

class BookTicketPage extends StatelessWidget {
  const BookTicketPage({Key? key, this.movie}) : super(key: key);

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookTicketController>(
      init: BookTicketController(),
      builder: (controller) => BookTicketView(
        movie: movie!,
        key: null,
      ),
    );
  }
}

class BookTicketView extends StatelessWidget {
  BookTicketView({Key? key, this.movie}) : super(key: key);
  late BookTicketController controller;
  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(BookTicketController());
    // call the function
    controller.loadSeats();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _getHeader(context),
            DateDaySelector(
              onChanged: (value) => controller.loadSeats(),
            ),
            const SizedBox(height: 30),
            const Screen(),
            const SeatSelector(),
          ],
        ),
      ),
      bottomNavigationBar: BuyButton(
        movie: movie!,
      ),
    );
  }

  Padding _getHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GlassIconButton(
            onTap: () => Navigator.pop(context),
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: movie!.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  const TextSpan(
                    text: '\n8:00',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BuyButton extends StatelessWidget {
  const BuyButton({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final BookTicketController controller = Get.find();

    return ScaleUpAnimation(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () => controller.book(context, movie),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            ),
            child: Obx(
              () {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Buy ${controller.state.value.totalSelected > 0 ? '${controller.state.value.totalSelected} tickets' : ''}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '\$${controller.state.value.totalPrice}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
