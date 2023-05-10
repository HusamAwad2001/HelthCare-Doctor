import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/core/global.dart';
import 'package:helth_care_doctor/services/fbNotifications.dart';
import 'package:helth_care_doctor/services/firestore_helper.dart';
import 'package:helth_care_doctor/view/widgets/loading_dialog.dart';

import '../models/chat_message.dart';
import '../models/chat_user.dart';
import '../models/topic_model.dart';
import '../services/fb_auth_controller.dart';
import 'package:http/http.dart' as http;

class NavigationController extends GetxController {
  final searchController = TextEditingController();
  FbNotifications notifications = FbNotifications();

  @override
  void onInit() {
    getAllTopics();
    // getAllDoctors();
    getAllClients();
    notifications.requestNotificationPermission();
    notifications.getDeviceToken().then((value) {});
    super.onInit();
  }

  int selectedIndex = 0;

  changeNavigation(int index) {
    selectedIndex = index;
    update();
  }

  List<TopicModel> topics = [];

  Future<void> getAllTopics() async {
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
        .where(
            (value) => value.title.toLowerCase().contains(input.toLowerCase()))
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

  /// -----------------------------------------------------------------
  var data = {
    'to' : 'dO6T1gNkQC-feXMvKjAtbI:APA91bHu0CNTNL8OZd87Palz1l4HfwN9tyPlAtS-XETBX7VOjy6hweqbxdmoXzLeqg6PPTzCgCF8dbWahxaOD3ZNHoNqRJKydzYQdR3RQHNu2RMbAKiXOpqi2K8m_kdXbkw4oqvae8ht',
    'priority' : 'high',
    'notification' : {
      'title' : 'Husam',
      'body' : 'Subscribe to my channel',
    },
  };
  Future<void> sendNotification({required String to, title, body}) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode({
        'to' : to,
        'priority' : 'high',
        'notification' : {
          'title' : title,
          'body' : body,
        },
      }),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'key=AAAA31_h-pY:APA91bEjqtwfUcWFx_jli2yJT94nhlNk1lyT6cxUPc66YbHZW5U4hcjoXe9SJP-thI4ucholBqVkH3SCFa51BhF111tPNH9bD64Rt0I0hp44D2_pbyeIDYrpd4NKy2Ncxi7IOFgvbwT5',
      },
    );
  }
}
