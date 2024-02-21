import 'package:firebaseapp/model/elavetadbutton.dart';
import 'package:firebaseapp/view/login.dart';
import 'package:firebaseapp/view/singup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 110,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Welcome ToDo',
              style: GoogleFonts.raleway(
                  fontSize: 50, fontWeight: FontWeight.w700),
            ),
            const Text(
              '...',
              style: TextStyle(
                  fontSize: 105, color: Color.fromARGB(255, 135, 178, 235)),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyElevatedButton(
                    width: 135,
                    colors: Colors.white,
                    color: Color.fromARGB(255, 146, 190, 227),
                    buttonText: 'Login',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login_page()));
                    }),
                const SizedBox(
                  width: 30,
                ),
                MyElevatedButton(
                    width: 135,
                    colors: Colors.black,
                    color: Colors.white,
                    buttonText: 'Sign Up',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signup_page()));
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
