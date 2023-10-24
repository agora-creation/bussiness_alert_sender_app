import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String _id = '';
  String _name = '';
  String _email = '';
  String _password = '';
  List<String> senderNumbers = [];
  String _token = '';
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get token => _token;
  DateTime get createdAt => _createdAt;

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data() ?? {};
    _id = map['id'] ?? '';
    _name = map['name'] ?? '';
    _email = map['email'] ?? '';
    _password = map['password'] ?? '';
    senderNumbers = _convertSenderNumbers(map['senderNumbers'] ?? []);
    _token = map['token'] ?? '';
    if (map['createdAt'] != null) {
      _createdAt = map['createdAt'].toDate() ?? DateTime.now();
    }
  }

  List<String> _convertSenderNumbers(List list) {
    List<String> ret = [];
    for (String id in list) {
      ret.add(id);
    }
    return ret;
  }
}
