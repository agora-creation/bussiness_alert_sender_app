import 'package:cloud_firestore/cloud_firestore.dart';

class SenderModel {
  String _id = '';
  String _number = '';
  String _name = '';
  String _password = '';
  List<String> userIds = [];
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get number => _number;
  String get name => _name;
  String get password => _password;
  DateTime get createdAt => _createdAt;

  SenderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data() ?? {};
    _id = map['id'] ?? '';
    _number = map['number'] ?? '';
    _name = map['name'] ?? '';
    _password = map['password'] ?? '';
    userIds = _convertUserIds(map['userIds'] ?? []);
    if (map['createdAt'] != null) {
      _createdAt = map['createdAt'].toDate() ?? DateTime.now();
    }
  }

  List<String> _convertUserIds(List list) {
    List<String> ret = [];
    for (String id in list) {
      ret.add(id);
    }
    return ret;
  }
}
