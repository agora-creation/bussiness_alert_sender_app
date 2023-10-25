import 'package:bussiness_alert_sender_app/models/sender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SenderService {
  String collection = 'sender';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void update(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).update(values);
  }

  Future<SenderModel?> select(String? number) async {
    SenderModel? ret;
    await firestore
        .collection(collection)
        .where('number', isEqualTo: number ?? 'error')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        ret = SenderModel.fromSnapshot(value.docs.first);
      }
    });
    return ret;
  }
}
