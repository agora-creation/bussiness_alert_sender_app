import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/sender_notice.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/services/sender_notice.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_text_form_field.dart';
import 'package:bussiness_alert_sender_app/widgets/link_text.dart';
import 'package:flutter/material.dart';

class SenderNoticeModScreen extends StatefulWidget {
  final SenderProvider senderProvider;
  final SenderNoticeModel notice;

  const SenderNoticeModScreen({
    required this.senderProvider,
    required this.notice,
    super.key,
  });

  @override
  State<SenderNoticeModScreen> createState() => _SenderNoticeModScreenState();
}

class _SenderNoticeModScreenState extends State<SenderNoticeModScreen> {
  SenderNoticeService senderNoticeService = SenderNoticeService();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.notice.title;
    contentController.text = widget.notice.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: Text('${widget.notice.title} : 編集'),
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
            label: '上記内容で保存',
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
              senderNoticeService.update({
                'id': widget.notice.id,
                'senderId': widget.notice.senderId,
                'title': titleController.text,
                'content': contentController.text,
              });
              if (!mounted) return;
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
          Center(
            child: LinkText(
              label: 'この通知テンプレートを削除',
              labelColor: kRedColor,
              onTap: () async {
                senderNoticeService.delete({
                  'id': widget.notice.id,
                  'senderId': widget.notice.senderId,
                });
                if (!mounted) return;
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
