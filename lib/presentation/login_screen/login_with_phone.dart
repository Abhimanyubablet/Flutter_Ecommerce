import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_practise_project/presentation/login_screen/verify_code_screen.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;
  final phonenumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextField(
              controller: phonenumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
              ),
            ),
            SizedBox(height: 70),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String phoneNumber = phonenumberController.text.trim();

                  // Ensure that the phone number starts with a plus sign
                  if (!phoneNumber.startsWith("+")) {
                    phoneNumber = "+$phoneNumber";
                  }

                  auth.verifyPhoneNumber(
                    phoneNumber: phoneNumber,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      toastMessage(e.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyCode(verificationId: verificationId, phone: phoneNumber),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (e) {
                      toastMessage(e.toString());
                    },
                  );
                },
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
