import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/sender_notice.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/screens/sender_notice_add.dart';
import 'package:bussiness_alert_sender_app/screens/sender_notice_mod.dart';
import 'package:bussiness_alert_sender_app/screens/sender_notice_send.dart';
import 'package:bussiness_alert_sender_app/services/sender_notice.dart';
import 'package:bussiness_alert_sender_app/widgets/bottom_right_button.dart';
import 'package:bussiness_alert_sender_app/widgets/notice_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SenderNoticeScreen extends StatefulWidget {
  final SenderProvider senderProvider;

  const SenderNoticeScreen({
    required this.senderProvider,
    super.key,
  });

  @override
  State<SenderNoticeScreen> createState() => _SenderNoticeScreenState();
}

class _SenderNoticeScreenState extends State<SenderNoticeScreen> {
  SenderNoticeService senderNoticeService = SenderNoticeService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBaseColor,
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: senderNoticeService
                .streamList(widget.senderProvider.sender?.id),
            builder: (context, snapshot) {
              List<SenderNoticeModel> notices = [];
              if (snapshot.hasData) {
                for (DocumentSnapshot<Map<String, dynamic>> doc
                    in snapshot.data!.docs) {
                  notices.add(SenderNoticeModel.fromSnapshot(doc));
                }
              }
              if (notices.isEmpty) {
                return const Center(
                  child: Text('通知テンプレートがありません\n右下のボタンから作成してください'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: 64,
                ),
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  return NoticeList(
                    notice: notices[index],
                    answerOnPressed: () {},
                    sendOnPressed: () => showBottomUpScreen(
                      context,
                      SenderNoticeSendScreen(
                        senderProvider: widget.senderProvider,
                        notice: notices[index],
                      ),
                    ),
                    modifyOnPressed: () => showBottomUpScreen(
                      context,
                      SenderNoticeModScreen(
                        senderProvider: widget.senderProvider,
                        notice: notices[index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          BottomRightButton(
            heroTag: 'addTemplate',
            label: '通知テンプレート作成',
            iconData: Icons.add,
            onPressed: () => showBottomUpScreen(
              context,
              SenderNoticeAddScreen(
                senderProvider: widget.senderProvider,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
