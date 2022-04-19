class UserModel {
  String userName;
  String photoUrl;
  String uid;

  UserModel(
      {required this.userName, required this.photoUrl, required this.uid});

  //convert user object into json

  Map<String, dynamic> toJson() {
    return {"userName": userName, "photoUrl": photoUrl, "uid": uid};
  }

  //convert json object into UserObject

  toObject(Map<String, dynamic> jsondata) {
    return UserModel(
        userName: jsondata["userName"],
        photoUrl: jsondata["photoUrl"],
        uid: jsondata["uid"]);
  }
}
