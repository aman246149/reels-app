import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadTask(Uint8List file, String child, bool isPost) async {
    Reference ref = storage.ref().child(child).child(_auth.currentUser!.uid);

    UploadTask task = ref.putData(file);

    TaskSnapshot snap = await task;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }
}
