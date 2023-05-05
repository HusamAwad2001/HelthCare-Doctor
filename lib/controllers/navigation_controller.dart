import 'package:get/get.dart';

class NavigationController extends GetxController {

  int selectedIndex = 0;
  changeNavigation(int index) {
    selectedIndex = index;
    update();
  }
}
