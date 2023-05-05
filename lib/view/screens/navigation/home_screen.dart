import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/constants/constants.dart';
import 'package:helth_care_doctor/controllers/navigation_controller.dart';

class HomeScreen extends GetView<NavigationController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: TextField(
            style: const TextStyle(fontFamily: 'Expo'),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              fillColor: Colors.grey.shade300,
              filled: true,
              prefixIcon: const Icon(Icons.search),
              hintText: 'بحث',
              hintStyle: const TextStyle(fontFamily: 'Expo'),
            ),
          ),
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
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.topics.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  final item = controller.topics[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        width: 1,
                        color: primaryColor.withOpacity(0.2),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundColor: primaryColor,
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(
                            fontFamily: 'Expo',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        item.title,
                        style: const TextStyle(fontFamily: 'Expo'),
                      ),
                      subtitle: Text(
                        item.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: 'Expo'),
                      ),
                      trailing: const Icon(
                        Icons.notification_important,
                        color: Colors.amber,
                      ),
                    ),
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
