import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/sender_notice.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/services/user.dart';
import 'package:bussiness_alert_sender_app/services/user_notice.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_sender_app/widgets/user_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SenderNoticeSendScreen extends StatefulWidget {
  final SenderProvider senderProvider;
  final SenderNoticeModel notice;

  const SenderNoticeSendScreen({
    required this.senderProvider,
    required this.notice,
    super.key,
  });

  @override
  State<SenderNoticeSendScreen> createState() => _SenderNoticeSendScreenState();
}

class _SenderNoticeSendScreenState extends State<SenderNoticeSendScreen> {
  UserService userService = UserService();
  UserNoticeService userNoticeService = UserNoticeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: Text('${widget.notice.title} : 一斉送信'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.notice.title,
              style: const TextStyle(
                color: kBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'SourceHanSansJP-Bold',
              ),
            ),
            Text(
              widget.notice.content,
              style: const TextStyle(
                color: kBlackColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text('以下の受信ユーザーに送信します'),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: kGreyColor),
                  bottom: BorderSide(color: kGreyColor),
                ),
              ),
              child: SizedBox(
                height: 250,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: userService.streamList(),
                  builder: (context, snapshot) {
                    List<UserModel> users = [];
                    List<String> userIds =
                        widget.senderProvider.sender?.userIds ?? [];
                    if (snapshot.hasData) {
                      for (DocumentSnapshot<Map<String, dynamic>> doc
                          in snapshot.data!.docs) {
                        UserModel user = UserModel.fromSnapshot(doc);
                        if (userIds.contains(user.id)) {
                          users.add(user);
                        }
                      }
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return UserList(user: users[index]);
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomLgButton(
              label: '一斉送信する',
              labelColor: kWhiteColor,
              backgroundColor: kBlueColor,
              onPressed: () async {
                List<String> userIds =
                    widget.senderProvider.sender?.userIds ?? [];
                for (String userId in userIds) {
                  userNoticeService.create({
                    'id': widget.notice.id,
                    'userId': userId,
                    'senderId': widget.notice.senderId,
                    'senderName': widget.senderProvider.sender?.name,
                    'title': widget.notice.title,
                    'content': widget.notice.content,
                    'isAnswer': widget.notice.isAnswer,
                    'isRead': false,
                    'createdAt': DateTime.now(),
                  });
                }
                if (!mounted) return;
                showMessage(context, '一斉送信が完了しました', true);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
