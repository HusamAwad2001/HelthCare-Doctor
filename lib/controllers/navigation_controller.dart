import 'package:get/get.dart';
import 'package:helth_care_doctor/services/firestore_helper.dart';
import 'package:helth_care_doctor/view/widgets/loading_dialog.dart';

import '../models/topic_model.dart';

class NavigationController extends GetxController {

  @override
  void onInit() {
    getAllTopics();
    super.onInit();
  }

  int selectedIndex = 0;
  changeNavigation(int index) {
    selectedIndex = index;
    update();
  }

  List<TopicModel> topics = [];
  Future<void> getAllTopics() async{
    topics = await FirestoreHelper.fireStoreHelper.getAllTopics();
    Get.back();
    update();
  }
}
