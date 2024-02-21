
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseapp/controller/db.dart';
import 'package:firebaseapp/controller/image.dart';
import 'package:firebaseapp/controller/location.dart';
import 'package:firebaseapp/firebase_options.dart';
import 'package:firebaseapp/model/notification.dart';
import 'package:firebaseapp/view/home.dart';
import 'package:firebaseapp/view/list.dart';
import 'package:firebaseapp/view/update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotification.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentData()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => ImageService()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListPage();
              } else {
                return const HomePage();
              }
            }),
        routes: {
          '/update': (context) => update(),
        },
      ),
    );
  }
}
