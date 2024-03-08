import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference ftexts =
      FirebaseFirestore.instance.collection('ftexts');
  Future<void> addText(String ftext) {
    return ftexts.add({'ftext': ftext, 'timestamp': Timestamp.now()});
  }
}
