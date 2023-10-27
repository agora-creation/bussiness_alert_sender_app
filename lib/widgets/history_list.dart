import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  final UserModel user;
  final String? answer;

  const HistoryList({
    required this.user,
    this.answer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: kGreyColor)),
      ),
      child: ListTile(
        title: Text(
          user.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceHanSansJP-Bold',
          ),
        ),
        leading: Text(answer ?? ''),
      ),
    );
  }
}
