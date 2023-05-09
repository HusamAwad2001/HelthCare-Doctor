import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/models/topic_model.dart';
import '../../constants/app_styles.dart';
import '../../constants/constants.dart';
import '../../controllers/update_topic_controller.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field_widget.dart';

class UpdateTopicScreen extends GetView<UpdateTopicController> {
  const UpdateTopicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'تعديل العنوان',
          style: TextStyle(
            fontFamily: 'Expo',
          ),
        ),
      ),
      body: GetBuilder<UpdateTopicController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => controller.pickImage(),
                  child: GetBuilder<UpdateTopicController>(
                    builder: (_) {
                      return controller.imageFile != null
                          ? CircleAvatar(
                              radius: 75,
                              backgroundImage: FileImage(controller.imageFile!),
                              child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    controller.imageFile != null
                                        ? Icons.edit
                                        : Icons.camera_alt_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    controller.argument.image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                TextFieldWidget(
                  controller: controller.titleController,
                  hintText: 'العنوان',
                ),
                const SizedBox(height: 15),
                TextFieldWidget(
                  controller: controller.descriptionController,
                  hintText: 'الوصف',
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 2),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'اختر نوع البيانات',
                    style: TextStyle(
                      fontFamily: 'Expo',
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      appBoxShadow(offsetY: 0, blurRadius: 2),
                    ],
                  ),
                  alignment: Alignment.centerRight,
                  child: DropdownButton<String>(
                    icon: const Icon(Icons.arrow_drop_down_circle_outlined)
                        .paddingOnly(left: 20),
                    // icon: const SizedBox(),
                    hint: const Text(
                      'اختر نوع البيانات',
                      style: TextStyle(
                        fontFamily: 'Expo',
                        fontSize: 18,
                      ),
                    ).paddingOnly(right: 20),
                    underline: const SizedBox(),
                    value: controller.typeOfInformation,
                    onChanged: (value) {
                      controller.typeOfInformation = value!;
                      controller.update();
                    },
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: 'Text',
                        child: Text(
                          'نص',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontFamily: 'Expo',
                            fontSize: 18,
                          ),
                        ).paddingOnly(right: 20, left: 20),
                      ),
                      DropdownMenuItem(
                        value: 'Image',
                        child: Text(
                          'صورة',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontFamily: 'Expo',
                            fontSize: 18,
                          ),
                        ).paddingOnly(right: 20, left: 20),
                      ),
                      DropdownMenuItem(
                        value: 'Video',
                        child: Text(
                          'فيديو',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontFamily: 'Expo',
                            fontSize: 18,
                          ),
                        ).paddingOnly(right: 20, left: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                controller.typeOfInformation == 'Text'
                    ? TextFieldWidget(
                        controller: controller.informationController,
                        hintText: 'البيانات',
                      )
                    : controller.typeOfInformation == 'Image'
                        ? GestureDetector(
                            onTap: () => controller.pickInfoImage(),
                            child: Container(
                              width: double.infinity,
                              height: 180,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  appBoxShadow(offsetY: 0, blurRadius: 2),
                                ],
                                image: controller.imageInfoFile != null
                                    ? DecorationImage(
                                        image: FileImage(
                                            controller.imageInfoFile!),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                  image: NetworkImage(controller.imageLink),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: controller.imageInfoFile == null
                                  ? controller.argument != null ? null : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'اختر صورة',
                                          style: TextStyle(
                                            fontFamily: 'Expo',
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(Icons.image, color: primaryColor),
                                      ],
                                    )
                                  : null,
                            ),
                          )
                        : GestureDetector(
                            onTap: () => controller.pickInfoVideo(),
                            child: Container(
                              width: double.infinity,
                              height: 180,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  appBoxShadow(offsetY: 0, blurRadius: 2),
                                ],
                              ),
                              child: GetBuilder<UpdateTopicController>(
                                  builder: (_) {
                                return controller.videoInfoFile == null
                                    ? controller.argument!= null
                                        ? controller.controller!.value.isInitialized
                                          ? Chewie(controller:controller.chewieController!)
                                          : const Center(child: CircularProgressIndicator())
                                        : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'اختر فيديو',
                                            style: TextStyle(
                                              fontFamily: 'Expo',
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Icon(Icons.video_library,
                                              color: Colors.red),
                                        ],
                                      )
                                    : Text(controller.videoNameFile!);
                              },
                              ),
                            ),
                          ),
                const SizedBox(height: 20),
                ButtonWidget(
                  width: double.infinity,
                  label: 'تعديل',
                  onPressed: () => controller.validate(),
                ),
              ],
            ).marginSymmetric(horizontal: 28),
          );
        },
      ),
    );
  }
}
