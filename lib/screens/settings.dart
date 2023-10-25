import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/screens/login.dart';
import 'package:bussiness_alert_sender_app/screens/sender_name.dart';
import 'package:bussiness_alert_sender_app/screens/sender_password.dart';
import 'package:bussiness_alert_sender_app/widgets/link_text.dart';
import 'package:bussiness_alert_sender_app/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final senderProvider = Provider.of<SenderProvider>(context);

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: const Text('各種設定'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SettingsListTile(
              iconData: Icons.person,
              label: '発信者名変更',
              onTap: () => pushScreen(
                context,
                SenderNameScreen(senderProvider: senderProvider),
              ),
            ),
            SettingsListTile(
              iconData: Icons.password,
              label: 'パスワード変更',
              onTap: () => pushScreen(
                context,
                SenderPasswordScreen(senderProvider: senderProvider),
              ),
            ),
            const SizedBox(height: 24),
            LinkText(
              label: 'ログアウト',
              labelColor: kRedColor,
              onTap: () async {
                await senderProvider.signOut();
                senderProvider.clearController();
                if (!mounted) return;
                pushReplacementScreen(context, const LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
