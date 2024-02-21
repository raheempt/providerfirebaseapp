import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/controller/db.dart';
import 'package:firebaseapp/view/adduser.dart';
import 'package:firebaseapp/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  final _reference = FirebaseFirestore.instance.collection('notes');

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 146, 184, 227),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUser()),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage())));
              },
              icon: Icon(Icons.logout)),
        ],
        backgroundColor: Color.fromARGB(255, 146, 184, 227),
        title: const Text(
          "Student Data",
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Color.fromARGB(255, 146, 175, 236),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: ChangeNotifierProvider(
              create: (_) => StudentData(),
              child: Consumer<StudentData>(
                builder: (BuildContext context, studentData, child) {
                  //  final   stream: _reference.snapshots();

                  // final data = studentData.getData();
                  return StreamBuilder(
                    stream: studentData.getData(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print('Error: ${snapshot.error}');
                        return Text('Error occurred');
                      }

                      //   return Center(child: Text('No Data Found'));
                      // }

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final studentData = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              left: 10.0,
                              top: 5.0,
                            ),
                            child: Card(
                              color: Color.fromARGB(255, 144, 172, 233),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/update',
                                    arguments: {
                                      'Name': studentData['Name'],
                                      'Age': studentData['Age'],
                                      'Email': studentData['Email'],
                                      'Phone': studentData['Phone'],
                                      'course': studentData['course'],
                                      'location': studentData['location'],
                                      'id': studentData.id,
                                    },
                                  );
                                },
                                leading: studentData['image'] != null
                                    ? Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE5E5E5),
                                          borderRadius:
                                              BorderRadius.circular(45),
                                        ),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              const Color(0xFFE5E5E5),
                                          backgroundImage: NetworkImage(
                                              studentData['image']),
                                        ),
                                      )
                                    : null,
                                trailing: IconButton(
                                  onPressed: () {
                                    Provider.of<StudentData>(context,
                                            listen: false)
                                        .delete(studentData.id);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                                title: Text(
                                  studentData['Name'],
                                ),
                                subtitle: Text(studentData['Email']),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
