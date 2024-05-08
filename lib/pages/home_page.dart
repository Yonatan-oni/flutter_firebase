import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/post_card.dart';
import 'package:flutter_firebase/services/firestore_service.dart';
import 'package:flutter_firebase/services/firestore_service_add_post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();
  final FirestoreServiceAddPostCard firestoreServiceAddPostCard =
      FirestoreServiceAddPostCard();
  final TextEditingController imgUrlController = TextEditingController(text: "https://media.istockphoto.com/id/1396814518/vector/image-coming-soon-no-photo-no-thumbnail-image-available-vector-illustration.webp?s=1024x1024&w=is&k=20&c=qNeCdQEGR07rW2FnwvIuuMaVmy0HkHPxdpYeJxLi3UE=");
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController btnNameController = TextEditingController();
  final TextEditingController btnLinkController = TextEditingController();

  void openNoteBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                children: [
                  TextField(
                    controller: imgUrlController,
                  ),
                  TextField(
                    controller: titleController,
                  ),
                  TextField(
                    controller: contentController,
                  ),
                  TextField(
                    controller: btnNameController,
                  ),
                  TextField(
                    controller: btnLinkController,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      firestoreServiceAddPostCard.addPostCards(
                          imgUrlController.text,
                          titleController.text,
                          contentController.text,
                          btnNameController.text,
                          btnLinkController.text);

                      imgUrlController.clear();
                      titleController.clear();
                      contentController.clear();
                      btnNameController.clear();
                      btnLinkController.clear();

                      Navigator.pop(context);
                    },
                    child: const Text("Post"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          const Text("Notes"),
          const Spacer(),
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),


      body: StreamBuilder<QuerySnapshot>(
        // stream: firestoreService.getNotesStream(),
        stream: firestoreServiceAddPostCard.getPostCardsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List postsList = snapshot.data!.docs;
            return ListView.builder(
                itemCount: postsList.length,
                itemBuilder: ((context, index) {
                  DocumentSnapshot document = postsList[index];
                  // String docId = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  String imgUrl = data['imgUrl'];
                  String title = data['title'];
                  String content = data['content'];
                  String btnName = data['btnName'];
                  // String btnLink = data['btnLink'];




                  return PostCard(
                   imageUrl: imgUrl,
                   title: title,
                   content: content,
                   btnText: btnName, 
                  );

                



                }));
          } else {
            return const Center(
              child: Text("No data...."),
            );
          }
        },
      ),
    );
  }
}
