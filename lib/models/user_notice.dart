import 'package:cloud_firestore/cloud_firestore.dart';

class UserNoticeModel {
  String _id = '';
  String _userId = '';
  String _senderNumber = '';
  String _senderName = '';
  String _title = '';
  String _content = '';
  bool _isAnswer = false;
  bool _isRead = false;
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get userId => _userId;
  String get senderNumber => _senderNumber;
  String get senderName => _senderName;
  String get title => _title;
  String get content => _content;
  bool get isAnswer => _isAnswer;
  bool get isRead => _isRead;
  DateTime get createdAt => _createdAt;

  UserNoticeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data() ?? {};
    _id = map['id'] ?? '';
    _userId = map['userId'] ?? '';
    _senderNumber = map['senderNumber'] ?? '';
    _senderName = map['senderName'] ?? '';
    _title = map['title'] ?? '';
    _content = map['content'] ?? '';
    _isAnswer = map['isAnswer'] ?? false;
    _isRead = map['isRead'] ?? false;
    if (map['createdAt'] != null) {
      _createdAt = map['createdAt'].toDate() ?? DateTime.now();
    }
  }
}
