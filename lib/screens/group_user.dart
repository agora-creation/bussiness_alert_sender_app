import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/models/group.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/services/user.dart';
import 'package:bussiness_alert_sender_app/widgets/user_checkbox_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupUserScreen extends StatefulWidget {
  final SenderProvider senderProvider;
  final GroupModel group;

  const GroupUserScreen({
    required this.senderProvider,
    required this.group,
    super.key,
  });

  @override
  State<GroupUserScreen> createState() => _GroupUserScreenState();
}

class _GroupUserScreenState extends State<GroupUserScreen> {
  UserService userService = UserService();
  List<String> groupUserIds = [];

  void _init() {
    setState(() {
      groupUserIds = widget.group.userIds;
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
        title: Text('${widget.group.name} : ユーザー追加'),
        actions: [
          TextButton(
            onPressed: () async {
              String? error = await widget.senderProvider.groupInUser(
                widget.group,
                groupUserIds,
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
            child: const Text('保存'),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: userService.streamList(),
        builder: (context, snapshot) {
          List<UserModel> users = [];
          List<String> userIds = widget.senderProvider.sender?.userIds ?? [];
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
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserModel user = users[index];
              var contain = groupUserIds.where((e) => e == user.id);
              return UserCheckboxListTile(
                user: user,
                value: contain.isNotEmpty,
                onChanged: (value) {
                  setState(() {
                    if (contain.isEmpty) {
                      groupUserIds.add(user.id);
                    } else {
                      groupUserIds.remove(user.id);
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
