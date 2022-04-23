import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reels/Models/CommentModel.dart';

class UploadCommentsToFirebase {
  uploadComment(String postId, String text, String username,
      String profilePhoto, int countComment) async {
    try {
      var allDocs = await FirebaseFirestore.instance
          .collection("videos")
          .doc(postId)
          .collection("comments")
          .get();

      int len = allDocs.docs.length;

      Comment comment = Comment(
          username: username,
          comment: text,
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: profilePhoto,
          uid: FirebaseAuth.instance.currentUser!.uid,
          id: "comment $len");

      await FirebaseFirestore.instance
          .collection("videos")
          .doc(postId)
          .collection("comments")
          .doc("comment $len")
          .set(comment.toJson());

      await FirebaseFirestore.instance
          .collection("videos")
          .doc(postId)
          .update({"commentCount": countComment + 1});
    } catch (e) {
      print(e.toString());
    }
  }
}
