import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SenderNameScreen extends StatefulWidget {
  final SenderProvider senderProvider;

  const SenderNameScreen({
    required this.senderProvider,
    super.key,
  });

  @override
  State<SenderNameScreen> createState() => _SenderNameScreenState();
}

class _SenderNameScreenState extends State<SenderNameScreen> {
  @override
  void initState() {
    super.initState();
    widget.senderProvider.nameController.text =
        widget.senderProvider.sender?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('発信者名変更'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CustomTextFormField(
            controller: widget.senderProvider.nameController,
            textInputType: TextInputType.name,
            maxLines: 1,
            label: '発信者名',
            color: kBlackColor,
            prefix: Icons.person,
          ),
          const SizedBox(height: 16),
          CustomLgButton(
            label: '変更内容を保存',
            labelColor: kWhiteColor,
            backgroundColor: kBlueColor,
            onPressed: () async {
              String? error = await widget.senderProvider.updateSenderName();
              if (error != null) {
                if (!mounted) return;
                showMessage(context, error, false);
                return;
              }
              widget.senderProvider.clearController();
              widget.senderProvider.reloadSender();
              if (!mounted) return;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
