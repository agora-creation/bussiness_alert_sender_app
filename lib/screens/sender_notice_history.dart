import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/sender_notice.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:bussiness_alert_sender_app/models/user_notice.dart';
import 'package:bussiness_alert_sender_app/services/user.dart';
import 'package:bussiness_alert_sender_app/services/user_notice.dart';
import 'package:bussiness_alert_sender_app/widgets/history_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SenderNoticeHistoryScreen extends StatefulWidget {
  final SenderNoticeModel notice;

  const SenderNoticeHistoryScreen({
    required this.notice,
    super.key,
  });

  @override
  State<SenderNoticeHistoryScreen> createState() =>
      _SenderNoticeHistoryScreenState();
}

class _SenderNoticeHistoryScreenState extends State<SenderNoticeHistoryScreen> {
  UserService userService = UserService();
  UserNoticeService userNoticeService = UserNoticeService();
  List<UserModel> users = [];

  void _init() async {
    List<UserModel> tmpUsers = await userService.selectList(
      widget.notice.sendUserIds,
    );
    setState(() {
      users = tmpUsers;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: Text('${widget.notice.title} : 送信履歴'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          UserModel user = users[index];
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: userNoticeService.streamList(
              user.id,
              widget.notice.senderId,
            ),
            builder: (context, snapshot) {
              UserNoticeModel? userNotice;
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isNotEmpty) {
                  userNotice =
                      UserNoticeModel.fromSnapshot(snapshot.data!.docs.first);
                }
              }
              return HistoryList(
                user: users[index],
                answer: userNotice?.answer,
              );
            },
          );
        },
      ),
    );
  }
}
