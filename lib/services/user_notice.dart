import 'package:cloud_firestore/cloud_firestore.dart';

class UserNoticeService {
  String collection = 'user';
  String subCollection = 'notice';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void create(Map<String, dynamic> values) {
    firestore
        .collection(collection)
        .doc(values['userId'])
        .collection(subCollection)
        .doc(values['id'])
        .set(values);
  }
}
