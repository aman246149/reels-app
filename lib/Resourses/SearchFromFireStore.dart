import 'package:cloud_firestore/cloud_firestore.dart';

class SearchFromFirestore {
  search(String text) async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .where("userName", isGreaterThanOrEqualTo: text)
          .get();

      print(snap.docs[0]["userName"]);
    } catch (e) {
      print(e.toString());
    }
  }
}
