import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/services/firestore_helper.dart';
import 'package:helth_care_doctor/view/widgets/loading_dialog.dart';

import '../models/topic_model.dart';

class NavigationController extends GetxController {

  final searchController = TextEditingController();

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

  Future<void> deleteTopic(TopicModel topic) async {
    LoadingDialog().dialog();
    await FirestoreHelper.fireStoreHelper.deleteTopic(topic);
    topics.removeWhere((element) => element.id == topic.id);
    Get.back();
    update();
  }

  List<TopicModel> filteredTopics = [];
  void filterTopics({required String input}) {
    filteredTopics = topics
        .where((value) =>
        value.title.toLowerCase().contains(input.toLowerCase()))
        .toList();
    update();
  }
}
