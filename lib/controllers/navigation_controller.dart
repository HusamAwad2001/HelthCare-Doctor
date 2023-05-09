import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/services/firestore_helper.dart';
import 'package:helth_care_doctor/view/widgets/loading_dialog.dart';

import '../models/chat_message.dart';
import '../models/chat_user.dart';
import '../models/topic_model.dart';
import '../services/fb_auth_controller.dart';

class NavigationController extends GetxController {

  final searchController = TextEditingController();

  @override
  void onInit() {
    getAllTopics();
    getAllDoctors();
    getAllClients();
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

  List<ChatUser> chatDoctors = [];
  getAllDoctors() async {
    chatDoctors = await FirestoreHelper.fireStoreHelper.getAllDoctors();
    update();
  }

  List<ChatUser> chatClients = [];
  getAllClients() async {
    chatClients = await FirestoreHelper.fireStoreHelper.getAllClients();
    update();
  }

  /// -----------------------------------------------------------------
  final messageContentController = TextEditingController();
  sendMessage(String otherUserId) async {
    ChatMessage message = ChatMessage(
      content: messageContentController.text,
      senderId: FbAuthController().getCurrentUser(),
    );
    await FirestoreHelper.fireStoreHelper.sendMessage(message, otherUserId);
  }
}
