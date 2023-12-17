// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shopping_practise_project/presentation/dashboard/dashboard.dart';
// import 'package:shopping_practise_project/presentation/login_screen/phone_register.dart';
//
// import '../regester_page/regester.dart';
//
// class VerifyCode extends StatefulWidget {
//   final String verificationId;
//   const VerifyCode({required this.verificationId,super.key});
//
//   @override
//   State<VerifyCode> createState() => _VerifyCodeState();
// }
//
// class _VerifyCodeState extends State<VerifyCode> {
//   bool loading=false;
//   final phonenumberController=TextEditingController();
//   final auth= FirebaseAuth.instance;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         title: Text("Verify"),
//       ),
//
//       body: Padding(
//
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             SizedBox(height: 50,),
//
//             TextField(
//               controller: phonenumberController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: "6 digit code",
//               ),
//             ),
//             SizedBox(height: 70,),
//
//             Container(
//               width: double.infinity,
//               child: ElevatedButton(
//
//                 onPressed: () async {
//                   final credential=PhoneAuthProvider.credential(
//                       verificationId: widget.verificationId,
//                       smsCode: phonenumberController.text.toString()
//                   );
//                   try {
//                     await auth.signInWithCredential(credential);
//                     Navigator.push(context,MaterialPageRoute(builder: (context)=> PhoneRegister()));
//                   }catch (e) {
//                     toastMessage(e.toString());
//                   }
//                 },
//                 child: Text("Verify code"),
//               ),
//             )
//
//           ],
//         ),
//       ),
//
//     );
//   }
//
//   void toastMessage(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_practise_project/presentation/dashboard/dashboard.dart';
import 'package:shopping_practise_project/presentation/login_screen/login_screen.dart';
import 'package:shopping_practise_project/presentation/login_screen/phone_register.dart';
import 'package:shopping_practise_project/presentation/regester_page/regester.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  final String phone;
  const VerifyCode({required this.verificationId, Key? key, required this.phone}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading = false;
  final phonenumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final usersRef = FirebaseFirestore.instance.collection('UserProfileData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextField(
              controller: phonenumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "6 digit code",
              ),
            ),
            SizedBox(height: 70,),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: phonenumberController.text.toString(),
                  );
                  try {
                    await auth.signInWithCredential(credential);

                    // Check if the phone number matches the one in UserProfileData
                    final currentUser = auth.currentUser;
                    if (currentUser != null) {
                      final mobile = currentUser.phoneNumber;
                      final userSnapshot = await usersRef
                          .where('mobile', isEqualTo: mobile)
                          .limit(1)
                          .get();

                      if (userSnapshot.docs.isNotEmpty) {
                        // Phone number matches, navigate to Dashboard
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashBoard()),
                        );
                      } else {
                        // Phone number does not match, navigate to PhoneRegister
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => PhoneRegister()),
                        // );

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PhoneRegister()),
                        );
                      }
                    }
                  } catch (e) {
                    toastMessage(e.toString());
                  }
                },
                child: Text("Verify code"),
              ),
            )
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
