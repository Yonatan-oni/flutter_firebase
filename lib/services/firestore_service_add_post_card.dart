import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServiceAddPostCard {
  //get collection
  final CollectionReference postCards =
      FirebaseFirestore.instance.collection("post_card");

  // create
  Future<void> addPostCards(String imgUrl, String title, String content,
      String btnName, String btnLink) {
    return postCards.add({
      'imgUrl': imgUrl,
      'title': title,
      'content': content,
      'btnName': btnName,
      'btnLink': btnLink,
      'timeStamp': Timestamp.now()
    });
  }

  //read
  Stream<QuerySnapshot> getPostCardsStream() {
    return postCards.orderBy('timeStamp', descending: true).snapshots();
  }
}
