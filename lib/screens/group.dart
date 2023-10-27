import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/group.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/screens/group_user.dart';
import 'package:bussiness_alert_sender_app/widgets/bottom_right_button.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_sm_button.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_text_form_field.dart';
import 'package:bussiness_alert_sender_app/widgets/group_card.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatefulWidget {
  final SenderProvider senderProvider;

  const GroupScreen({
    required this.senderProvider,
    super.key,
  });

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    List<GroupModel> groups = widget.senderProvider.sender?.groups ?? [];
    return Container(
      color: kBaseColor,
      child: Stack(
        children: [
          groups.isEmpty
              ? const Center(
                  child: Text('グループがありません\n右下のボタンから作成してください'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: 64,
                  ),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    return GroupCard(
                      group: groups[index],
                      userOnPressed: () => showBottomUpScreen(
                        context,
                        GroupUserScreen(
                          senderProvider: widget.senderProvider,
                          group: groups[index],
                        ),
                      ),
                      removeOnPressed: () => showDialog(
                        context: context,
                        builder: (context) => RemoveDialog(
                          senderProvider: widget.senderProvider,
                          group: groups[index],
                        ),
                      ),
                    );
                  },
                ),
          BottomRightButton(
            heroTag: 'addGroup',
            label: 'グループ作成',
            iconData: Icons.add,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddDialog(
                senderProvider: widget.senderProvider,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddDialog extends StatefulWidget {
  final SenderProvider senderProvider;

  const AddDialog({
    required this.senderProvider,
    super.key,
  });

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: nameController,
            textInputType: TextInputType.name,
            maxLines: 1,
            label: 'グループ名',
            color: kBlackColor,
            prefix: Icons.short_text,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSmButton(
                label: 'やめる',
                labelColor: kWhiteColor,
                backgroundColor: kGreyColor,
                onPressed: () => Navigator.pop(context),
              ),
              CustomSmButton(
                label: '作成する',
                labelColor: kWhiteColor,
                backgroundColor: kBlueColor,
                onPressed: () async {
                  String? error = await widget.senderProvider.createGroup(
                    nameController.text,
                  );
                  if (error != null) {
                    if (!mounted) return;
                    showMessage(context, error, false);
                    return;
                  }
                  widget.senderProvider.reloadSender();
                  if (!mounted) return;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RemoveDialog extends StatefulWidget {
  final SenderProvider senderProvider;
  final GroupModel group;

  const RemoveDialog({
    required this.senderProvider,
    required this.group,
    super.key,
  });

  @override
  State<RemoveDialog> createState() => _RemoveDialogState();
}

class _RemoveDialogState extends State<RemoveDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.group.name,
            style: const TextStyle(
              color: kBlackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'このグループを削除しますか？',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSmButton(
                label: 'やめる',
                labelColor: kWhiteColor,
                backgroundColor: kGreyColor,
                onPressed: () => Navigator.pop(context),
              ),
              CustomSmButton(
                label: '削除する',
                labelColor: kWhiteColor,
                backgroundColor: kRedColor,
                onPressed: () async {
                  String? error = await widget.senderProvider.removeGroup(
                    widget.group,
                  );
                  if (error != null) {
                    if (!mounted) return;
                    showMessage(context, error, false);
                    return;
                  }
                  widget.senderProvider.reloadSender();
                  if (!mounted) return;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
