import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/services/sender_notice.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SenderNoticeAddScreen extends StatefulWidget {
  final SenderProvider senderProvider;

  const SenderNoticeAddScreen({
    required this.senderProvider,
    super.key,
  });

  @override
  State<SenderNoticeAddScreen> createState() => _SenderNoticeAddScreenState();
}

class _SenderNoticeAddScreenState extends State<SenderNoticeAddScreen> {
  SenderNoticeService senderNoticeService = SenderNoticeService();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: const Text('通知テンプレート作成'),
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
          CustomTextFormField(
            controller: titleController,
            textInputType: TextInputType.name,
            maxLines: 1,
            label: '通知タイトル',
            color: kBlackColor,
            prefix: Icons.short_text,
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: contentController,
            textInputType: TextInputType.multiline,
            maxLines: null,
            label: '通知内容',
            color: kBlackColor,
            prefix: Icons.short_text,
          ),
          const SizedBox(height: 16),
          CustomLgButton(
            label: '上記内容で作成',
            labelColor: kWhiteColor,
            backgroundColor: kBlueColor,
            onPressed: () async {
              if (titleController.text == '') {
                if (!mounted) return;
                showMessage(context, '通知タイトルを入力してください', false);
                return;
              }
              if (contentController.text == '') {
                if (!mounted) return;
                showMessage(context, '通知内容を入力してください', false);
                return;
              }
              String id = senderNoticeService.id(
                widget.senderProvider.sender?.id,
              );
              senderNoticeService.create({
                'id': id,
                'senderId': widget.senderProvider.sender?.id,
                'title': titleController.text,
                'content': contentController.text,
                'isAnswer': false,
                'createdAt': DateTime.now(),
              });
              if (!mounted) return;
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
