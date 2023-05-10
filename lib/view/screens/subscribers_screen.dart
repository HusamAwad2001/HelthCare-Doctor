import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helth_care_doctor/models/notification_model.dart';
import 'package:helth_care_doctor/view/widgets/empty_list.dart';

import '../../constants/constants.dart';

class SubscribersScreen extends StatelessWidget {
  const SubscribersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<NotificationModel> list = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'المشتركين',
          style: TextStyle(
            fontFamily: 'Expo',
          ),
        ),
      ),
      body: list.isEmpty
          ? const EmptyList(text: 'لا يوجد مشتركين')
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: list.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                final item = list[index];
                return GestureDetector(
                  onTap: () async {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        width: 1,
                        color: primaryColor.withOpacity(0.2),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: 'Expo'),
                      ),
                      subtitle: Text(
                        item.phone,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Expo',
                          fontSize: 12,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.send,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
