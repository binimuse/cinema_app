import 'package:get/get.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  double top = -300;
  double left = -300;

  void updatePosition(double deltaX, double deltaY) {
    top += deltaY * 1.5;
    left += deltaX * 1.5;
    update(); // This will trigger the UI to rebuild
  }
}
