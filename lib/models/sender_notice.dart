import 'package:cloud_firestore/cloud_firestore.dart';

class SenderNoticeModel {
  String _id = '';
  String _senderId = '';
  String _title = '';
  String _content = '';
  bool _isAnswer = false;
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get senderId => _senderId;
  String get title => _title;
  String get content => _content;
  bool get isAnswer => _isAnswer;
  DateTime get createdAt => _createdAt;

  SenderNoticeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data() ?? {};
    _id = map['id'] ?? '';
    _senderId = map['senderId'] ?? '';
    _title = map['title'] ?? '';
    _content = map['content'] ?? '';
    _isAnswer = map['isAnswer'] ?? false;
    if (map['createdAt'] != null) {
      _createdAt = map['createdAt'].toDate() ?? DateTime.now();
    }
  }
}
