import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'B-ALERT',
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceHanSansJP-Bold',
                    ),
                  ),
                  Text(
                    '一斉通知アプリ - 発信者用',
                    style: TextStyle(
                      color: kBlackColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SpinKitFadingCircle(color: kBlackColor),
            ],
          ),
        ),
      ),
    );
  }
}
