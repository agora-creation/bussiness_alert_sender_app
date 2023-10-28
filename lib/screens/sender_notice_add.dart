import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/services/sender_notice.dart';
import 'package:bussiness_alert_sender_app/widgets/answer_checkbox_list_tile.dart';
import 'package:bussiness_alert_sender_app/widgets/choice_text_field.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_sm_button.dart';
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
  bool? isAnswer = false;
  List<String> choices = ['同意する', '同意しない'];

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
          const SizedBox(height: 8),
          AnswerCheckboxListTile(
            value: isAnswer,
            onChanged: (value) {
              setState(() {
                isAnswer = value;
              });
            },
          ),
          isAnswer == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      '選択肢を設定する',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: choices.length,
                      itemBuilder: (context, index) {
                        String choice = choices[index];
                        return ChoiceTextField(
                          value: choice,
                          onChanged: (value) {
                            choices[index] = value;
                          },
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomSmButton(
                          label: '追加',
                          labelColor: kWhiteColor,
                          backgroundColor: kBlueColor,
                          onPressed: () {
                            setState(() {
                              choices.add('');
                            });
                          },
                        ),
                        const SizedBox(width: 4),
                        CustomSmButton(
                          label: '削除',
                          labelColor: kWhiteColor,
                          backgroundColor: kRedColor,
                          onPressed: () {
                            setState(() {
                              choices.removeLast();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                )
              : Container(),
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
                'isAnswer': isAnswer ?? false,
                'choices': choices,
                'isSend': false,
                'sendUserIds': [],
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
