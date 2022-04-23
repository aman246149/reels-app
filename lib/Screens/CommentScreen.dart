import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reels/Resourses/UploadComments.dart';
import 'package:timeago/timeago.dart' as tago;
import '../Models/CommentModel.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String username;
  final String profilePhoto;
  final int countComment;

  const CommentScreen(
      {Key? key,
      required this.postId,
      required this.username,
      required this.profilePhoto,
      required this.countComment})
      : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("videos")
                    .doc(widget.postId)
                    .collection("comments")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No comments Yet"),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final Comment comment =
                          Comment.fromSnap(snapshot.data!.docs[index].data());
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(comment.profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(
                              comment.username,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              comment.comment,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              tago.format(
                                comment.datePublished.toDate(),
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              comment.likes.length.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {},
                          child:
                              Icon(Icons.favorite, size: 25, color: Colors.red),
                        ),
                      );
                    },
                  );
                },
              )),
              Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () async {
                    await UploadCommentsToFirebase().uploadComment(
                        widget.postId,
                        _commentController.text,
                        widget.username,
                        widget.profilePhoto,
                        widget.countComment);
                    setState(() {
                      _commentController.clear();
                    });
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
