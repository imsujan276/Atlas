import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({
    this.uid
  });

  // Collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference blogPostCollection = Firestore.instance.collection('blogPosts');

  // update user data
  Future updateUserData(String fullName, String email, String password) async {
    return await userCollection.document(uid).setData({
      'fullName': fullName,
      'email': email,
      'password': password,
    });
  }

  // get user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).getDocuments();
    print(snapshot.documents[0].data);
    return snapshot;
  }

  // save blog post
  Future saveBlogPost(String title, String author, String content) async {
    return await blogPostCollection.add({
      'blogPostTitle': title,
      'blogPostAuthor': author,
      'blogPostContent': content,
      'createdDate': new DateTime.now()
    });
  }
}