import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CarouselProvider extends ChangeNotifier {
  int currentPageIndex = 0;

  void onPageChanged(int index) {
    currentPageIndex = index;
    notifyListeners();
  }
}

class CarouselController extends GetxController {
  var currentPageIndex = 0.obs;
}
