import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/group.dart';
import 'package:bussiness_alert_sender_app/models/sender_notice.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/services/fm.dart';
import 'package:bussiness_alert_sender_app/services/sender_notice.dart';
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
  SenderNoticeService senderNoticeService = SenderNoticeService();
  UserService userService = UserService();
  UserNoticeService userNoticeService = UserNoticeService();
  FmServices fmServices = FmServices();
  List<GroupModel> groups = [];
  List<DropdownMenuItem> groupItems = [
    const DropdownMenuItem(
      value: '全ての受信ユーザー',
      child: Text('全ての受信ユーザー'),
    ),
  ];
  String? groupSelected = '全ての受信ユーザー';
  List<String> sendUserIds = [];

  void _init() {
    setState(() {
      groups = widget.senderProvider.sender?.groups ?? [];
      for (GroupModel group in groups) {
        groupItems.add(DropdownMenuItem(
          value: group.name,
          child: Text(group.name),
        ));
      }
      sendUserIds = widget.senderProvider.sender?.userIds ?? [];
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
        title: Text('${widget.notice.title} : 一斉送信'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const Text(
            '一斉送信が完了しましたら、「編集」「一斉送信」ができなくなります。',
            style: TextStyle(
              color: kRedColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
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
          const SizedBox(height: 24),
          const Text(
            '送信するグループを選択してください',
            style: TextStyle(
              color: kRedColor,
              fontSize: 14,
            ),
          ),
          DropdownButton(
            isExpanded: true,
            items: groupItems,
            value: groupSelected,
            onChanged: (value) {
              setState(() {
                groupSelected = value;
                if (groupSelected != '全ての受信ユーザー') {
                  GroupModel group = groups.singleWhere(
                    (e) => e.name == groupSelected,
                  );
                  sendUserIds = group.userIds;
                } else {
                  sendUserIds = widget.senderProvider.sender?.userIds ?? [];
                }
              });
            },
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kGreyColor),
                bottom: BorderSide(color: kGreyColor),
              ),
            ),
            child: SizedBox(
              height: 200,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: userService.streamList(),
                builder: (context, snapshot) {
                  List<UserModel> users = [];
                  if (snapshot.hasData) {
                    for (DocumentSnapshot<Map<String, dynamic>> doc
                        in snapshot.data!.docs) {
                      UserModel user = UserModel.fromSnapshot(doc);
                      if (sendUserIds.contains(user.id)) {
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
              for (String userId in sendUserIds) {
                UserModel? user = await userService.selectId(userId);
                if (user != null) {
                  fmServices.send(
                    token: user.token,
                    title: widget.notice.title,
                    body: widget.notice.content,
                  );
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
                  senderNoticeService.update({
                    'id': widget.notice.id,
                    'senderId': widget.notice.senderId,
                    'isSend': true,
                  });
                }
              }
              if (!mounted) return;
              showMessage(context, '一斉送信が完了しました', true);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
