import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_sm_button.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final Function()? removeOnPressed;

  const UserCard({
    required this.user,
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
              Text(
                user.name,
                style: const TextStyle(
                  color: kBlackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              CustomSmButton(
                label: '強制脱退',
                labelColor: kWhiteColor,
                backgroundColor: kRedColor,
                onPressed: removeOnPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
