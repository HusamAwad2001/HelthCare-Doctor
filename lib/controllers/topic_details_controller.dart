import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/services/firestore_helper.dart';
import 'package:helth_care_doctor/view/widgets/loading_dialog.dart';
import 'package:helth_care_doctor/view/widgets/snack.dart';
import 'package:video_player/video_player.dart';

import '../models/topic_model.dart';

class TopicDetailsController extends GetxController {
  TopicModel argument = Get.arguments;
  VideoPlayerController? controller;

  ChewieController? chewieController;
  late bool isHidden;
  void updateHiddenTopic(bool isHidden) async {
    LoadingDialog().dialog();
    await FirestoreHelper.fireStoreHelper.updateHiddenTopic(
      argument.id!,
      isHidden,
    );
    this.isHidden = isHidden;
    Get.back();
    update();
  }

  @override
  void onInit() {
    isHidden = argument.hidden;
    controller = VideoPlayerController.network(
      argument.infoType == "Video" ? argument.information : '',
    )..initialize().then((value) {
        chewieController = ChewieController(
          videoPlayerController: controller!,
          autoPlay: true,
        );
        update();
      });
    super.onInit();
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}
