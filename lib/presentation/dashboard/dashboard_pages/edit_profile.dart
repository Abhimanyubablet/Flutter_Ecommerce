import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../dashboard.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Enter your name",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                controller: _mobileController,
                decoration: InputDecoration(
                  hintText: "Enter your mobile number",
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.all(15),
            //   child: TextField(
            //     controller: _passwordController,
            //     obscureText: true,
            //     onChanged: (newPassword) {
            //       // Handle the new password change
            //     },
            //     decoration: InputDecoration(
            //       hintText: "Enter your password",
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () async {
                  await _updateUserProfile();

                },
                child: Text("Save Changes"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _updateUserProfile() async {

    User? user = FirebaseAuth.instance.currentUser;

    // Get the values from the controllers
    String newName = _nameController.text;
    String newMobile = _mobileController.text;
    // String newPassword = _passwordController.text;


    // Replace "userId" with the actual user ID or identifier
    String? userId = user?.uid;

    // Update the data in Firestore using the values newName, newMobile, and newPassword
    await FirebaseFirestore.instance.collection("UserProfileData").doc(userId).update({
      "name": newName,
      "mobile": newMobile,
      // "password": newPassword,
      "userId":userId
    });

   Navigator.push(context,MaterialPageRoute(builder: (context)=> DashBoard()));
  }
}
