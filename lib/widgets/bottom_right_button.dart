import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:flutter/material.dart';

class BottomRightButton extends StatelessWidget {
  final String heroTag;
  final String label;
  final IconData iconData;
  final Function()? onPressed;

  const BottomRightButton({
    required this.heroTag,
    required this.label,
    required this.iconData,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: FloatingActionButton.extended(
          heroTag: heroTag,
          backgroundColor: kBlueColor.withOpacity(0.9),
          onPressed: onPressed,
          label: Text(label),
          icon: Icon(iconData),
        ),
      ),
    );
  }
}
