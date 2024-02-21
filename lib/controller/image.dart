import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class ImageService with ChangeNotifier {
  File? file;
  XFile? pickedFile;
  String? imageURL;

  // A C C E S S    I M A G E
  Future<File> getImag(bool isCamera) async {
    final picker = ImagePicker();
    if (isCamera) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else {
      // pickedFile = await picker.pickImage(source: ImageSource.camera);
    }
    if (pickedFile != null) {
      file = File(pickedFile!.path);
      notifyListeners();
    }
    return file!;
  }

  Future<String> uploadImage(var imageFile) async {
    if (imageFile != null) {
      String uniqueFilename = DateTime.now().toString();
      TaskSnapshot imagetoUploadRef =
      await FirebaseStorage.instance.ref().child('images').child(uniqueFilename)
       .putFile(imageFile!);
      imageURL = await imagetoUploadRef.ref.getDownloadURL();
      print(imageURL);
      print("uploaded");
      notifyListeners();
    }
    return imageURL!;
  }
}


