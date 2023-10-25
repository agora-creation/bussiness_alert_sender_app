import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/services/user.dart';
import 'package:bussiness_alert_sender_app/widgets/bottom_right_button.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_sm_button.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_text_form_field.dart';
import 'package:bussiness_alert_sender_app/widgets/user_card.dart';
import 'package:bussiness_alert_sender_app/widgets/user_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  final SenderProvider senderProvider;

  const UserScreen({
    required this.senderProvider,
    super.key,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBaseColor,
      child: Stack(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
              if (users.isEmpty) {
                return const Center(
                  child: Text('受信ユーザーはいません'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    user: users[index],
                    removeOnPressed: () => showDialog(
                      context: context,
                      builder: (context) => RemoveDialog(
                        senderProvider: widget.senderProvider,
                        user: users[index],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          BottomRightButton(
            heroTag: 'addUser',
            label: '受信ユーザーを追加',
            iconData: Icons.person_add,
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
  UserService userService = UserService();
  UserModel? user;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user == null
              ? CustomTextFormField(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  maxLines: 1,
                  label: 'メールアドレス',
                  color: kBlackColor,
                  prefix: Icons.mail,
                )
              : UserList(user: user!),
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
              user == null
                  ? CustomSmButton(
                      label: '検索する',
                      labelColor: kWhiteColor,
                      backgroundColor: kBlueColor,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        UserModel? tmpUser = await userService.select(
                          emailController.text,
                        );
                        if (tmpUser == null) {
                          if (!mounted) return;
                          showMessage(context, '受信ユーザーが見つかりません', false);
                          return;
                        }
                        setState(() {
                          user = tmpUser;
                        });
                      },
                    )
                  : CustomSmButton(
                      label: '追加する',
                      labelColor: kWhiteColor,
                      backgroundColor: kBlueColor,
                      onPressed: () async {
                        String? error =
                            await widget.senderProvider.addUser(user!);
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
  final UserModel user;

  const RemoveDialog({
    required this.senderProvider,
    required this.user,
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
          UserList(user: widget.user),
          const SizedBox(height: 8),
          const Text(
            'この受信ユーザーを強制脱退させますか？',
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
                label: '強制脱退させる',
                labelColor: kWhiteColor,
                backgroundColor: kRedColor,
                onPressed: () async {
                  String? error =
                      await widget.senderProvider.removeUser(widget.user);
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
