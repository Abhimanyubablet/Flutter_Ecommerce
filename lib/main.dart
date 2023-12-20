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




