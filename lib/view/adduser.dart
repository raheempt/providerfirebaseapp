import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/controller/db.dart';
import 'package:firebaseapp/controller/image.dart';
import 'package:firebaseapp/controller/location.dart';
import 'package:firebaseapp/model/coustumtextfiled.dart';
import 'package:firebaseapp/model/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUser extends StatefulWidget {
  AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final rollnumberController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final courseController = TextEditingController();
  final _key = GlobalKey<FormState>();

  User? currentUser = FirebaseAuth.instance.currentUser;
  File? file;

  //  B O T T O M     S H E E T
  Future<void> bottom() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Choose Photo'),
              onTap: () async {
                file = await Provider.of<ImageService>(context, listen: false)
                    .getImag(true);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    final location = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 146, 190, 227),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 146, 184, 227), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Column(
                  children: [
                    const Text(
                      'Add Student',
                      style: TextStyle(fontSize: 35),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Color.fromARGB(255, 146, 172, 227)
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                bottom();
                              },
                              child: Consumer<ImageService>(
                                builder: (context, value, child) {
                                  return Container(
                                    child: (file == null)
                                        ? const Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: CircleAvatar(
                                                  radius: 60,
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 14,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Color.fromARGB(
                                                      255, 89, 88, 88),
                                                ),
                                              )
                                            ],
                                          )
                                        : CircleAvatar(
                                            radius: 60,
                                            backgroundColor: Colors.white,
                                            backgroundImage: FileImage(file!),
                                          ),
                                  );
                                },
                              ),
                            ),
                          const  Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: nameController,
                              labelText: 'First Name',
                              hintText: 'First Name',
                              validator: nameValidate,
                              icons: Icon(Icons.person),
                            ),
                       const      Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: ageController,
                              labelText: 'Age',
                              hintText: 'Age',
                              validator: ageValidate,
                              icons: Icon(Icons.person),
                            ),
                         const    Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: emailController,
                              labelText: 'Email',
                              hintText: 'Email',
                              validator: emailValidate,
                              icons: Icon(Icons.email),
                            ),
                       const      Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: phoneController,
                              labelText: 'Phone',
                              hintText: 'Phone',
                              validator: phoneValidate,
                              icons: Icon(Icons.phone),
                            ),
                        const     Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: courseController,
                              labelText: 'Course',
                              hintText: 'Course',
                              validator: nameValidate,
                              icons: Icon(Icons.person),
                            ),
                      const       Sizedbox(height: 15.0),
                            Text(location.currentAddress),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                onPressed: () async {
                                  await Provider.of<LocationProvider>(context,
                                          listen: false)
                                      .getLocation();
                                },
                                child: Text("Add location"),
                              ),
                            ),
                            Sizedbox(height: 15.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    final name = nameController.text;
                                    final age = ageController.text;
                                    final email = emailController.text;
                                    final phone = phoneController.text;
                                    final course = courseController.text;
                                    // file image
                                    print("hello");
                                    Provider.of<StudentData>(context,
                                            listen: false)
                                        .addData(
                                            name,
                                            age,
                                            email,
                                            phone,
                                            course,
                                            location.currentAddress,
                                            file,
                                            context);
                                    print('completed');
                                    nameController.clear();
                                    ageController.clear();
                                    emailController.clear();
                                    phoneController.clear();
                                    courseController.clear();
                                    Provider.of<StudentData>(context,
                                        listen: false);
                                  }
                                  Navigator.pop(context);
                                  location.clearCurrentAddress();
                                },
                                child: Text('Submit'),
                              ),
                            ),
                            Sizedbox(height: 45.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
