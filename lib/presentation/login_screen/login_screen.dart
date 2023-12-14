import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_practise_project/presentation/dashboard/dashboard.dart';
import 'package:shopping_practise_project/presentation/login_screen/login_with_phone.dart';
import 'package:shopping_practise_project/presentation/regester_page/regester.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../widgets/rounded_btn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
        backgroundColor: Color(0xFF0D4619),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 16.0, horizontal: 30.0), // Customize padding
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/e_com.png',
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Text('Wlecome to E-com',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xFF625A5A),
                              )),
                        ),
                        Container(
                          child: Text(
                            'Sign in to continue',
                            style: TextStyle(color: Color(0xFF0D4619)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: emailLoginController,
                    decoration: InputDecoration(
                      labelText: "Your Email",
                      prefixIcon: Icon(Icons.email),
                      border:
                          OutlineInputBorder(), // Add this line for a border
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextFormField(
                    controller: passwordLoginController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      border:
                          OutlineInputBorder(), // Add this line for a border
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Container(
                    // width: MediaQuery.of(context).size.width ,
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.only(top: 20),

                    child: RoundedButton(
                      btnName: "Sign In",
                        callback: () {

                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: emailLoginController.text,
                              password: passwordLoginController.text)
                              .then((value) async {
                            // If sign-in is successful
                            Fluttertoast.showToast(
                                msg: "Login successful",
                                backgroundColor: Colors.blueGrey,
                                timeInSecForIosWeb: 5);

                            // Store the user document ID in shared preferences
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('userDocId', value.user?.uid ?? '');

                            // Navigate to the 'dashboard' route
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                          }).catchError((error) {
                            // If there's an error during sign-in
                            print("Error: ${error.toString()}");
                            Fluttertoast.showToast(
                                msg: "Invalid email and password",
                                backgroundColor: Colors.blueGrey,
                                timeInSecForIosWeb: 5);
                          });


                        },

                      bgColor: Color(0xFF0D4619),
                      textStyle: TextStyle(fontFamily: AutofillHints.givenName),
                    ),

                  ),
                ]
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  children: [

                    Container(
                      width: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.8,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    Container(
                      child: Text("OR" ,style: TextStyle(fontWeight: FontWeight.w500)),
                    ),

                    SizedBox(
                      width: 10,
                    ),

                    Container(
                      width: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.8,
                        ),
                      ),
                    ),


                  ],
                ),

                Column(
                  children: [


                    Column(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF625A5A),
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the children horizontally
                            children: [
                              Container(
                                child: Text(
                                  "Don't have an account?",
                                ),
                              ),
                              Center(
                                child: Container(
                                  child: TextButton(
                                    onPressed: () {
                                     Navigator.push(context,MaterialPageRoute(builder: (context)=>Regester()));
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF625A5A),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginWithPhone()));                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.black,
                            )
                        ),
                        child: Center(
                          child: Text("Login with phone"),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(

                      child:Center(
                        child: SizedBox(
                          height: 50,
                          width: 300,
                          child: SignInButton(
                            onPressed: (){
                              _handleGoogleSignIn();

                            },
                            Buttons.google,text: "Sign up with google",),

                        ),
                      ),
                    )
                  ],
                )

              ],
            ),

          ),

        ),
      ),
    );
  }
  void _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        Fluttertoast.showToast(
          msg: "Google Login successful",
          backgroundColor: Colors.blueGrey,
          timeInSecForIosWeb: 5,
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()) );
      } else {
        Fluttertoast.showToast(
          msg: "Google Login failed",
          backgroundColor: Colors.blueGrey,
          timeInSecForIosWeb: 5,
        );
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "Google Login Failed",
        backgroundColor: Colors.blueGrey,
        timeInSecForIosWeb: 5,
      );
    }
  }
}
