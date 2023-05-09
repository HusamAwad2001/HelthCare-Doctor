import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/routes/routes.dart';
import 'package:helth_care_doctor/view/widgets/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../models/topic_model.dart';
import '../services/firestore_helper.dart';
import '../services/storage_helper.dart';
import '../view/widgets/snack.dart';

class UpdateTopicController extends GetxController {
  TopicModel argument = Get.arguments;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final informationController = TextEditingController();
  String typeOfInformation = "Text";
  String imageLink = '';
  String videoLink = '';

  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();

  /// Pick_Image
  File? imageFile;

  Future<void> pickImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      imageFile = File(_pickedFile!.path);
    } else {
      Snack().show(type: false, message: 'من فضلك قم بإختيار أيقومة من المعرض');
    }
    update();
  }

  /// Pick_Info_Image
  File? imageInfoFile;

  Future<void> pickInfoImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      imageInfoFile = File(_pickedFile!.path);
      print(imageInfoFile);
    } else {
      Snack().show(type: false, message: 'من فضلك قم بإختيار صورة من المعرض');
    }
    update();
  }

  /// Pick_Info_Video
  File? videoInfoFile;
  String? videoNameFile;

  Future<void> pickInfoVideo() async {
    _pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (_pickedFile != null) {
      videoInfoFile = File(_pickedFile!.path);
      videoNameFile = _pickedFile!.name;
    } else {
      Snack().show(type: false, message: 'من فضلك قم بإختيار فيديو من المعرض');
    }
    update();
  }

  String? information;
  bool hidden = false;

  Future<void> addNewTopic() async {
    LoadingDialog().dialog();
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await StorageHelper.instance.uploadImage(imageFile!);
    }else{
      imageUrl = argument.image;
    }
    if (typeOfInformation == "Text") {
      if (informationController.text.isNotEmpty) {
        information = informationController.text;
      }else{
        information = argument.information;
      }
    } else if (typeOfInformation == "Image") {
      if (imageInfoFile != null) {
        information = await StorageHelper.instance.uploadImage(imageInfoFile!);
      }else{
        imageUrl = imageLink;
      }
    } else {
      if (videoInfoFile != null) {
        information = await StorageHelper.instance.uploadImage(videoInfoFile!);
      }else{
        imageUrl = videoLink;
      }
    }
    TopicModel newTopic = TopicModel(
      id: argument.id,
      title: titleController.text,
      description: descriptionController.text,
      image: imageUrl!,
      information: information!,
      infoType: typeOfInformation,
      hidden: hidden,
    );
    await FirestoreHelper.fireStoreHelper.updateTopic(newTopic);
    // Get.offAll(Routes.navigationScreen);
    Get.back();
    update();
  }

  validate() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (imageFile != null || argument.image != null) {
      if (titleController.text.isNotEmpty || argument.title != null) {
        if (descriptionController.text.isNotEmpty || argument.description != null) {
          if (typeOfInformation == "Text") {
            if (informationController.text.isNotEmpty || argument.information != null) {
              // information = informationController.text;
              addNewTopic();
            } else {
              Snack().show(type: false, message: 'يجب إضافة البيانات');
            }
          } else if (typeOfInformation == "Image") {
            if (imageInfoFile != null || argument.information != null) {
              // information = await StorageHelper.instance.uploadImage(imageInfoFile!);
              addNewTopic();
            } else {
              Snack().show(type: false, message: 'يجب إختيار صورة');
            }
          } else {
            if (videoInfoFile != null) {
              // information = await StorageHelper.instance.uploadImage(videoInfoFile!);
              addNewTopic();
            } else {
              Snack().show(type: false, message: 'يجب إختيار فيديو');
            }
          }
        } else {
          Snack().show(type: false, message: 'يجب إضافة الوصف');
        }
      } else {
        Snack().show(type: false, message: 'يجب إضافة العنوان');
      }
    } else {
      Snack().show(type: false, message: 'يجب إختيار صورة');
    }
  }

  @override
  void onInit() {
    titleController.text = argument.title;
    descriptionController.text = argument.description;
    typeOfInformation = argument.infoType;
    checkInformationType();
    super.onInit();
  }

  VideoPlayerController? controller;

  ChewieController? chewieController;

  checkInformationType() {
    if (argument.infoType == 'Text') {
      informationController.text = argument.information;
    }
    if (argument.infoType == 'Image') {
      imageLink = argument.information;
    }
    if (argument.infoType == 'Video') {
      videoLink = argument.information;
      controller = VideoPlayerController.network(
        argument.infoType == "Video" ? argument.information : '',
      )..initialize().then((value) {
          chewieController = ChewieController(
            videoPlayerController: controller!,
          );
          update();
        });
    }
  }
}
