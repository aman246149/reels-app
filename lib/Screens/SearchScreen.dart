import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Resourses/SearchFromFireStore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  bool isShownUser = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onChanged: (String val) {
              setState(() {
                isShownUser = true;
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                isShownUser = true;
              });
            },
          ),
        ),
        body: isShownUser == false
            ? const Center(
                child: Text(
                  "search for users",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              )
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("userName", isGreaterThanOrEqualTo: _controller.text)
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
                    return Text("No user found with this name");
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                        ),
                        title: Text(snapshot.data!.docs[index]["userName"]),
                      );
                    },
                  );
                },
              ));
  }
}
