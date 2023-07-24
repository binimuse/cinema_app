import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/book_ticket_controller.dart';

class SeatSelector extends StatelessWidget {
  const SeatSelector();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookTicketController>();
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.width /
            controller.columns *
            controller.getState().seats /
            controller.columns,
        child: Stack(
          children: [
            GridView.count(
              crossAxisCount: controller.columns,
              children: List.generate(
                controller.getState().seats,
                (index) => Seat(
                  status: controller.getStatus(index),
                  onTap: () => controller.select(index),
                ),
              ),
            ),
            if (controller.getState().status.isLoading)
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width /
                        controller.columns *
                        controller.getState().seats /
                        controller.columns,
                  ),
                ),
              ),
            if (controller.getState().status.isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: .5,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Seat extends StatelessWidget {
  const Seat({super.key, required this.status, this.onTap});

  final SeatStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (status == SeatStatus.empty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: status == SeatStatus.selected
            ? Colors.white
            : status == SeatStatus.busy
                ? Colors.white24
                : null,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: InkWell(
        onTap: status == SeatStatus.busy ? null : onTap,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
