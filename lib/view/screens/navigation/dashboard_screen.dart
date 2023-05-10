import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:helth_care_doctor/constants/app_styles.dart';
import 'package:helth_care_doctor/constants/constants.dart';
import 'package:helth_care_doctor/controllers/navigation_controller.dart';
import 'package:helth_care_doctor/services/firestore_helper.dart';
import 'package:helth_care_doctor/view/widgets/button_widget.dart';
import 'package:helth_care_doctor/view/widgets/text_field_widget.dart';

import '../../../../routes/routes.dart';
import '../../../models/notification_model.dart';
import '../../widgets/empty_list.dart';

class DashboardScreen extends GetView<NavigationController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        GetBuilder<NavigationController>(
          builder: (_) {
            return controller.topics.isEmpty
                ? const SizedBox()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: TextField(
                      controller: controller.searchController,
                      style: const TextStyle(fontFamily: 'Expo'),
                      onChanged: (value) =>
                          controller.filterTopics(input: value),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: controller.searchController.text.isEmpty
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  controller.searchController.clear();
                                  controller.update();
                                },
                                child: const Icon(Icons.close),
                              ),
                        hintText: 'بحث',
                        hintStyle: const TextStyle(fontFamily: 'Expo'),
                      ),
                    ),
                  );
          },
        ),
        const SizedBox(height: 20),
        Expanded(
          child: FutureBuilder(
            future: controller.getAllTopics(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'حدث خطأ ما !\n يرجى المحاولة مرة أخرى',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Expo'),
                  ),
                );
              }
              return GetBuilder<NavigationController>(
                builder: (_) {
                  return controller.topics.isEmpty
                      ? const EmptyList()
                      : controller.searchController.text.isNotEmpty &&
                              controller.filteredTopics.isEmpty
                          ? const EmptyList(text: 'لا يوجد عناوين', value: 150)
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.filteredTopics.isEmpty
                                  ? controller.topics.length
                                  : controller.filteredTopics.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10);
                              },
                              itemBuilder: (context, index) {
                                final item = controller.topics[index];
                                return GestureDetector(
                                  onTap: () async {
                                    await controller
                                        .getAllSubscriber(item.id!)
                                        .then((value) {
                                      Get.toNamed(
                                        Routes.subscribersScreen,
                                        arguments: value,
                                      );
                                    });
                                    // controller.getAllSubscriber(
                                    //   controller.filteredTopics.isEmpty
                                    //       ? item.id!
                                    //       : controller.filteredTopics[index].id!,
                                    // );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        width: 1,
                                        color: primaryColor.withOpacity(0.2),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            NetworkImage(item.image),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      title: Text(
                                        controller.filteredTopics.isEmpty
                                            ? item.title
                                            : controller
                                                .filteredTopics[index].title,
                                        style:
                                            const TextStyle(fontFamily: 'Expo'),
                                      ),
                                      subtitle: Text(
                                        controller.filteredTopics.isEmpty
                                            ? item.description
                                            : controller.filteredTopics[index]
                                                .description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'Expo',
                                          fontSize: 12,
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.getAllViews(
                                                context,
                                                item,
                                              );
                                            },
                                            child: const Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: () {
                                              Get.dialog(
                                                GestureDetector(
                                                  onTap: () => Get.back(),
                                                  child: Scaffold(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    body: Container(
                                                      color: primaryColor
                                                          .withOpacity(0.2),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        // mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'إرسال الإشعارات لكل المشتركين',
                                                            style:
                                                                getRegularStyle(),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          TextFieldWidget(
                                                            controller:
                                                                TextEditingController(),
                                                            hintText:
                                                                'عنوان الإشعار',
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          TextFieldWidget(
                                                            controller:
                                                                TextEditingController(),
                                                            hintText: 'وصف الإشعار',
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          ButtonWidget(
                                                            label: 'إرسال',
                                                            onPressed: () {},
                                                          ),
                                                        ],
                                                      ).marginSymmetric(
                                                          horizontal: 50),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.send,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                },
              );
            },
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 10);
  }
}
