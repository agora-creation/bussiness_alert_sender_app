import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/screens/home.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_lg_button.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final senderProvider = Provider.of<SenderProvider>(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
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
              Column(
                children: [
                  CustomTextFormField(
                    controller: senderProvider.numberController,
                    textInputType: TextInputType.number,
                    maxLines: 1,
                    label: '発信者番号',
                    color: kBlackColor,
                    fillColor: kWhiteColor,
                    prefix: Icons.numbers,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFormField(
                    controller: senderProvider.passwordController,
                    obscureText: true,
                    textInputType: TextInputType.visiblePassword,
                    maxLines: 1,
                    label: 'パスワード',
                    color: kBlackColor,
                    fillColor: kWhiteColor,
                    prefix: Icons.password,
                  ),
                  const SizedBox(height: 8),
                  CustomLgButton(
                    label: 'ログイン',
                    labelColor: kBlackColor,
                    backgroundColor: kWhiteColor,
                    onPressed: () async {
                      String? error = await senderProvider.signIn();
                      if (error != null) {
                        if (!mounted) return;
                        showMessage(context, error, false);
                        return;
                      }
                      senderProvider.clearController();
                      if (!mounted) return;
                      pushReplacementScreen(context, const HomeScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
