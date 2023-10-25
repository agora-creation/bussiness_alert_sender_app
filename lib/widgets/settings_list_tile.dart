import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool topBorder;
  final Function()? onTap;

  const SettingsListTile({
    required this.iconData,
    required this.label,
    this.topBorder = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: topBorder
            ? const Border(
                top: BorderSide(color: kBlackColor),
                bottom: BorderSide(color: kBlackColor),
              )
            : const Border(
                bottom: BorderSide(color: kBlackColor),
              ),
      ),
      child: ListTile(
        leading: Icon(iconData, color: kBlackColor),
        title: Text(
          label,
          style: const TextStyle(color: kBlackColor),
        ),
        trailing: const Icon(Icons.chevron_right, color: kBlackColor),
        onTap: onTap,
      ),
    );
  }
}
