import 'package:bussiness_alert_sender_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  String collection = 'user';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel?> selectId(String? userId) async {
    UserModel? ret;
    await firestore.collection(collection).doc(userId).get().then((value) {
      ret = UserModel.fromSnapshot(value);
    });
    return ret;
  }

  Future<UserModel?> selectEmail(String? email) async {
    UserModel? ret;
    await firestore
        .collection(collection)
        .where('email', isEqualTo: email ?? 'error')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        ret = UserModel.fromSnapshot(value.docs.first);
      }
    });
    return ret;
  }

  Future<List<UserModel>> selectList(List<String> userIds) async {
    List<UserModel> ret = [];
    await firestore.collection(collection).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (DocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
          UserModel user = UserModel.fromSnapshot(doc);
          if (userIds.contains(user.id)) {
            ret.add(user);
          }
        }
      }
    });
    return ret;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamList() {
    return firestore
        .collection(collection)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
