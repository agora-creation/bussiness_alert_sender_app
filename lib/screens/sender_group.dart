import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/widgets/bottom_right_button.dart';
import 'package:flutter/material.dart';

class SenderGroupScreen extends StatefulWidget {
  final SenderProvider senderProvider;

  const SenderGroupScreen({
    required this.senderProvider,
    super.key,
  });

  @override
  State<SenderGroupScreen> createState() => _SenderGroupScreenState();
}

class _SenderGroupScreenState extends State<SenderGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBaseColor,
      child: Stack(
        children: [
          const Center(
            child: Text('グループがありません\n右下のボタンから作成してください'),
          ),
          BottomRightButton(
            heroTag: 'addGroup',
            label: 'グループ作成',
            iconData: Icons.add,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
