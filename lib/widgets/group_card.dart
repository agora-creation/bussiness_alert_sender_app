import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/group.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_sm_button.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final GroupModel group;
  final Function()? userOnPressed;
  final Function()? removeOnPressed;

  const GroupCard({
    required this.group,
    this.userOnPressed,
    this.removeOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: const TextStyle(
                      color: kBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${group.userIds.length}人設定中',
                    style: const TextStyle(
                      color: kGreyColor,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomSmButton(
                    label: 'ユーザー追加',
                    labelColor: kWhiteColor,
                    backgroundColor: kBlueColor,
                    onPressed: userOnPressed,
                  ),
                  const SizedBox(width: 8),
                  CustomSmButton(
                    label: '削除',
                    labelColor: kWhiteColor,
                    backgroundColor: kRedColor,
                    onPressed: removeOnPressed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
