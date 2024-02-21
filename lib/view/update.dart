import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/controller/db.dart';
import 'package:firebaseapp/model/coustumtextfiled.dart';
import 'package:firebaseapp/model/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class update extends StatefulWidget {
  update({
    Key? key,
  }) : super(key: key);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  final rollnumberController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final courseController = TextEditingController();
  late String location;
  final _key = GlobalKey<FormState>();

  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = args['Name'];
    ageController.text = args['Age'];
    emailController.text = args['Email'];
    phoneController.text = args['Phone'];
    courseController.text = args['course'];
    location = args['location'].toString();
    final studentId = args['id'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 140, 176, 224),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 151, 160, 243), Colors.white],
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
                      'update Student',
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
                            Color.fromARGB(255, 138, 174, 240)
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Column(
                          children: [
                            const Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: nameController,
                              labelText: 'First Name',
                              hintText: 'First Name',
                              validator: nameValidate,
                              icons: const Icon(Icons.person),
                            ),
                            const Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: ageController,
                              labelText: 'Age',
                              hintText: 'Age',
                              validator: ageValidate,
                              icons: const Icon(Icons.person),
                            ),
                            const Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: emailController,
                              labelText: 'Email',
                              hintText: 'Email',
                              validator: emailValidate,
                              icons: const Icon(Icons.email),
                            ),
                            const Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: phoneController,
                              labelText: 'Phone',
                              hintText: 'Phone',
                              validator: phoneValidate,
                              icons: const Icon(Icons.phone),
                            ),
                            const Sizedbox(height: 15.0),
                            CustomTextFormField(
                              controller: courseController,
                              labelText: 'Course',
                              hintText: 'Course',
                              validator: nameValidate,
                              icons: const Icon(Icons.person),
                            ),
                            const Sizedbox(height: 15.0),
                            Text(location),
                            const Sizedbox(height: 15.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                onPressed: () {
                                  if (_key.currentState!.validate()) {
                                    Provider.of<StudentData>(context,
                                            listen: false)
                                        .upDatedata(
                                            studentId,
                                            nameController,
                                            emailController,
                                            ageController,
                                            phoneController,
                                            courseController,
                                            location);
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text('Update'),
                              ),
                            ),
                            const Sizedbox(height: 45.0),
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
