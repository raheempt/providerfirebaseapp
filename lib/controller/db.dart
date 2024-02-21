import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseapp/controller/image.dart';
import 'package:flutter/material.dart';

class StudentData extends ChangeNotifier {
  ImageService imageService = ImageService();
  late Reference imagetoUploadRef;
  // final FirebaseService firebaseService = FirebaseService();
  // late String imageURL;

  getData() {
    User? userId = FirebaseAuth.instance.currentUser;
    final data = FirebaseFirestore.instance
        .collection("notes")
        .where("userId", isEqualTo: userId?.uid)
        .snapshots();
    return data;
  }

  addData(String name, String age, String email, String phone, String course,
      String location, dynamic image, BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload an image'),
        ),
      );
    } else {
      String imageURL = await imageService.uploadImage(image);

      print('uploading image');

      await FirebaseFirestore.instance.collection("notes").doc().set(
        {
          "Name": name,
          "Age": age,
          "Email": email,
          "Phone": phone,
          "course": course,
          "location": location,
          "image": imageURL,
          "userId": currentUser?.uid,
        },
      ).then((value) {
        print('done');
      });

      print('uploaded');
      notifyListeners();
    }
  }

  Future upDatedata(
    dynamic studentId,
    TextEditingController name,
    TextEditingController email,
    TextEditingController age,
    TextEditingController phone,
    TextEditingController course,
    String location,
  ) async {
    final CollectionReference userdata =
        FirebaseFirestore.instance.collection("notes");
    final data = {
      'Name': name.text,
      'Age': age.text,
      'Email': email.text,
      'Phone': phone.text,
      'course': course.text,
      'location': location,
    };
    userdata.doc(studentId).update(data);
  }

  final students = FirebaseFirestore.instance.collection("notes");
  void delete(docid) {
    students.doc(docid).delete();
  }
}
