import 'package:cloud_firestore/cloud_firestore.dart';

class UserNoticeModel {
  String _id = '';
  String _userId = '';
  String _senderId = '';
  String _senderName = '';
  String _title = '';
  String _content = '';
  bool _isAnswer = false;
  String _answer = '';
  bool _isRead = false;
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get userId => _userId;
  String get senderId => _senderId;
  String get senderName => _senderName;
  String get title => _title;
  String get content => _content;
  bool get isAnswer => _isAnswer;
  String get answer => _answer;
  bool get isRead => _isRead;
  DateTime get createdAt => _createdAt;

  UserNoticeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data() ?? {};
    _id = map['id'] ?? '';
    _userId = map['userId'] ?? '';
    _senderId = map['senderId'] ?? '';
    _senderName = map['senderName'] ?? '';
    _title = map['title'] ?? '';
    _content = map['content'] ?? '';
    _isAnswer = map['isAnswer'] ?? false;
    _answer = map['answer'] ?? '';
    _isRead = map['isRead'] ?? false;
    if (map['createdAt'] != null) {
      _createdAt = map['createdAt'].toDate() ?? DateTime.now();
    }
  }
}
