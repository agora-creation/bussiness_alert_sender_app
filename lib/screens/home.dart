import 'package:bussiness_alert_sender_app/common/style.dart';
import 'package:bussiness_alert_sender_app/providers/sender.dart';
import 'package:bussiness_alert_sender_app/widgets/custom_persistent_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PersistentTabController? controller;

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final senderProvider = Provider.of<SenderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(senderProvider.sender?.name ?? ''),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: CustomPersistentTabView(
        context: context,
        controller: controller,
        screens: [
          Container(),
          Container(),
          Container(),
          Container(),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.calendar_month),
            title: '通知内容作成',
            activeColorPrimary: kBaseColor,
            inactiveColorPrimary: kGreyColor,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.checklist),
            title: '送信履歴',
            activeColorPrimary: kBaseColor,
            inactiveColorPrimary: kGreyColor,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.timer),
            title: '回答履歴',
            activeColorPrimary: kBaseColor,
            inactiveColorPrimary: kGreyColor,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.chat),
            title: '受信者一覧',
            activeColorPrimary: kBaseColor,
            inactiveColorPrimary: kGreyColor,
          ),
        ],
      ),
    );
  }
}
