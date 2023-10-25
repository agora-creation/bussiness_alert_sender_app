import 'package:cloud_firestore/cloud_firestore.dart';

class SenderNoticeService {
  String collection = 'sender';
  String subCollection = 'notice';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String id(String? senderId) {
    return firestore
        .collection(collection)
        .doc(senderId ?? 'error')
        .collection(subCollection)
        .doc()
        .id;
  }

  void create(Map<String, dynamic> values) {
    firestore
        .collection(collection)
        .doc(values['senderId'])
        .collection(subCollection)
        .doc(values['id'])
        .set(values);
  }

  void update(Map<String, dynamic> values) {
    firestore
        .collection(collection)
        .doc(values['senderId'])
        .collection(subCollection)
        .doc(values['id'])
        .update(values);
  }

  void delete(Map<String, dynamic> values) {
    firestore
        .collection(collection)
        .doc(values['senderId'])
        .collection(subCollection)
        .doc(values['id'])
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamList(String? senderId) {
    return firestore
        .collection(collection)
        .doc(senderId ?? 'error')
        .collection(subCollection)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
