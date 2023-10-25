import 'package:bussiness_alert_sender_app/common/functions.dart';
import 'package:bussiness_alert_sender_app/models/sender.dart';
import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:bussiness_alert_sender_app/services/sender.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  authenticated,
  uninitialized,
  authenticating,
  unauthenticated,
}

class SenderProvider with ChangeNotifier {
  AuthStatus _status = AuthStatus.uninitialized;
  AuthStatus get status => _status;
  FirebaseAuth? auth;
  User? _authUser;
  User? get authUser => _authUser;
  SenderService senderService = SenderService();
  SenderModel? _sender;
  SenderModel? get sender => _sender;

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  void clearController() {
    nameController.clear();
    numberController.clear();
    passwordController.clear();
    rePasswordController.clear();
  }

  SenderProvider.initialize() : auth = FirebaseAuth.instance {
    auth?.authStateChanges().listen(_onStateChanged);
  }

  Future<String?> signIn() async {
    String? error;
    if (numberController.text == '') error = '発信者番号を入力してください';
    if (passwordController.text == '') error = 'パスワードを入力してください';
    try {
      _status = AuthStatus.authenticating;
      notifyListeners();
      await auth?.signInAnonymously().then((value) async {
        _authUser = value.user;
        SenderModel? tmpSender = await senderService.select(
          numberController.text,
        );
        if (tmpSender != null &&
            tmpSender.password == passwordController.text) {
          _sender = tmpSender;
          await setPrefsString('number', tmpSender.number);
        } else {
          await auth?.signOut();
          error = 'ログインに失敗しました';
        }
      });
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      error = 'ログインに失敗しました';
    }
    return error;
  }

  Future<String?> updateSenderName() async {
    String? error;
    if (nameController.text == '') error = '発信者名を入力してください';
    try {
      senderService.update({
        'id': _sender?.id,
        'name': nameController.text,
      });
    } catch (e) {
      error = e.toString();
    }
    return error;
  }

  Future<String?> updateSenderPassword() async {
    String? error;
    if (passwordController.text == '') error = 'パスワードを入力してください';
    if (passwordController.text != rePasswordController.text) {
      error = 'パスワードが一致しません';
    }
    try {
      senderService.update({
        'id': _sender?.id,
        'password': passwordController.text,
      });
    } catch (e) {
      error = e.toString();
    }
    return error;
  }

  Future<String?> addUser(UserModel user) async {
    String? error;
    try {
      List<String> userIds = _sender?.userIds ?? [];
      if (!userIds.contains(user.id)) {
        userIds.add(user.id);
      }
      senderService.update({
        'id': _sender?.id,
        'userIds': userIds,
      });
    } catch (e) {
      error = e.toString();
    }
    return error;
  }

  Future<String?> removeUser(UserModel user) async {
    String? error;
    try {
      List<String> userIds = _sender?.userIds ?? [];
      if (userIds.contains(user.id)) {
        userIds.remove(user.id);
      }
      senderService.update({
        'id': _sender?.id,
        'userIds': userIds,
      });
    } catch (e) {
      error = e.toString();
    }
    return error;
  }

  Future signOut() async {
    await auth?.signOut();
    _status = AuthStatus.unauthenticated;
    _sender = null;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future reloadSender() async {
    String? number = await getPrefsString('number');
    _sender = await senderService.select(number);
    notifyListeners();
  }

  Future _onStateChanged(User? authUser) async {
    if (authUser == null) {
      _status = AuthStatus.unauthenticated;
    } else {
      _authUser = authUser;
      _status = AuthStatus.authenticated;
      String? number = await getPrefsString('number');
      _sender = await senderService.select(number);
    }
    notifyListeners();
  }
}
