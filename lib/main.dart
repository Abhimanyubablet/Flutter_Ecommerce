import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_practise_project/routes/app_routes.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          storageBucket: 'gs://flutterproductorder.appspot.com',
          apiKey: 'AIzaSyDm_Z48VhR63gSFaGRbxl2F6yJW15-UYbk',
          appId: '1:904983470069:android:a826d7058d022b38accabc',
          messagingSenderId: '904983470069',
          projectId: 'flutterproductorder'
      )
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF0D4619,
          <int, Color>{
            50: Color(0xFF0D4619),
            100: Color(0xFF0D4619),
            200: Color(0xFF0D4619),
            300: Color(0xFF0D4619),
            400: Color(0xFF0D4619),
            500: Color(0xFF0D4619),
            600: Color(0xFF0D4619),
            700: Color(0xFF0D4619),
            800: Color(0xFF0D4619),
            900: Color(0xFF0D4619),
          },
        ),
      ),

      routes: AppRoutes.routes,
    ),
  );
}




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'edit_profile.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({Key? key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   final CollectionReference _items =
//       FirebaseFirestore.instance.collection('UserProfileData');
//
//   User? _user;
//   String? _userName;
//   String? _userEmail;
//   String? _userMobile;
//   String? _userDocId;
//
//   final auth = FirebaseAuth.instance;
//   // Method to fetch user data
//
//   Future<void> _fetchUserData() async {
//     final currentUser = auth.currentUser;
//     if (_user != null) {
//       final mobile = currentUser?.phoneNumber;
//       try {
//         QuerySnapshot<Object?> querySnapshot = await _items
//             .where('mobile',
//                 isEqualTo: mobile) // Replace with your phone number
//             .limit(1)
//             .get();
//
//         if (querySnapshot.docs.isNotEmpty) {
//           DocumentSnapshot<Object?> snapshot = querySnapshot.docs.first;
//           Map<String, dynamic>? userData =
//               snapshot.data() as Map<String, dynamic>?;
//
//           if (userData != null) {
//             // Store data in SharedPreferences
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             prefs.setString('userName', userData['name']);
//             prefs.setString('userEmail', userData['email']);
//             prefs.setString('userMobile', userData['mobile']);
//             prefs.setString('userDocId', snapshot.id);
//
//             // Update state with the fetched data
//             setState(() {
//               _userName = userData['name'];
//               _userEmail = userData['email'];
//               _userMobile = userData['mobile'];
//               _userDocId = snapshot.id;
//             });
//           }
//         } else {
//           // Handle the case where the user data doesn't exist
//           print(
//               "User data does not exist in Firestore for phone number");
//         }
//       } catch (e) {
//         // Handle errors during data fetching
//         print("Error fetching user data: $e");
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     FirebaseAuth.instance.authStateChanges().listen((user) {
//       setState(() {
//         _user = user;
//       });
//
//       if (_user != null) {
//         // Fetch user profile data from Firestore
//         _fetchUserData();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile Page"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Center(
//         child: _user != null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   SizedBox(height: 10),
//                   if (_userName != null) Text(_userName!),
//                   SizedBox(height: 10),
//                   if (_userEmail != null) Text(_userEmail!),
//                   SizedBox(height: 20),
//                   if (_userMobile != null) Text(_userMobile!),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Use _userDocId wherever you need it
//                       print("Document ID: $_userDocId");
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => EditProfile()),
//                       );
//                     },
//                     child: Text("Edit Profile"),
//                   ),
//                 ],
//               )
//             : CircularProgressIndicator(), // Show loading indicator
//       ),
//     );
//   }
// }
