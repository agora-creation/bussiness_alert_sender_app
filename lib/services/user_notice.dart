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

  Stream<QuerySnapshot<Map<String, dynamic>>> streamList(
    String? userId,
    String? senderId,
  ) {
    return firestore
        .collection(collection)
        .doc(userId ?? 'error')
        .collection(subCollection)
        .where('senderId', isEqualTo: senderId ?? 'error')
        .snapshots();
  }
}
