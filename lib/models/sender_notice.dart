import 'package:cloud_firestore/cloud_firestore.dart';

class SenderNoticeModel {
  String _id = '';
  String _senderId = '';
  String _title = '';
  String _content = '';
  bool _isAnswer = false;
  List<String> choices = [];
  bool _isSend = false;
  List<String> sendUserIds = [];
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get senderId => _senderId;
  String get title => _title;
  String get content => _content;
  bool get isAnswer => _isAnswer;
  bool get isSend => _isSend;
  DateTime get createdAt => _createdAt;

  SenderNoticeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data() ?? {};
    _id = map['id'] ?? '';
    _senderId = map['senderId'] ?? '';
    _title = map['title'] ?? '';
    _content = map['content'] ?? '';
    _isAnswer = map['isAnswer'] ?? false;
    choices = _convertChoices(map['choices'] ?? []);
    _isSend = map['isSend'] ?? false;
    sendUserIds = _convertSendUserIds(map['sendUserIds'] ?? []);
    if (map['createdAt'] != null) {
      _createdAt = map['createdAt'].toDate() ?? DateTime.now();
    }
  }

  List<String> _convertChoices(List list) {
    List<String> ret = [];
    for (String id in list) {
      ret.add(id);
    }
    return ret;
  }

  List<String> _convertSendUserIds(List list) {
    List<String> ret = [];
    for (String id in list) {
      ret.add(id);
    }
    return ret;
  }
}
