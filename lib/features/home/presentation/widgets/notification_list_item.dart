import 'package:daeawt/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/model/notification.dart';

class NotificationsListItem extends StatelessWidget {
  const NotificationsListItem({Key? key, required this.notificationModel})
      : super(key: key);
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Column(
            children: [
              Image.asset(ImageAssests.notificationIcon),
              const SizedBox(
                height: 40,
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        notificationModel.title,
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      // Text(
                      // notificationModel.c,
                      //   style: TextStyle(
                      //       fontSize: 10, fontWeight: FontWeight.w400),
                      // ),
                    ],
                  ),
                  Text(
                    notificationModel.body,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
