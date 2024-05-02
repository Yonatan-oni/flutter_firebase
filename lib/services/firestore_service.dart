import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  //create
  Future<void> addNotes(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  //read
  Stream<QuerySnapshot> getNotesStream() {
    return notes.orderBy('timestamp', descending: true).snapshots();
  }

  //update

  //delete
}
