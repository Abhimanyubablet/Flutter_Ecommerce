import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_practise_project/presentation/dashboard/dashboard_pages/productDetails.dart';
import 'package:shopping_practise_project/presentation/login_screen/login_screen.dart';

import '../../../widgets/rounded_btn.dart';
import 'OrderPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color(0xFF0D4619),
        title: Text("Home"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
              });
            },
            icon: Icon(Icons.logout),),
          SizedBox(width: 20,)
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('/ProductName').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // or any other loading indicator
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No data available'); // Handle case where there is no data
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic>? data =
              document.data() as Map<String, dynamic>?;

              if (data == null ||
                  data['product_image'] == null ||
                  data['product_title'] == null ||
                  data['product_desc'] == null ||
                  data['product_price'] == null) {
                return SizedBox();
              }

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Image.network(
                    data['product_image']!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(data['product_title']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${data['product_desc']}'),
                      Text('Rs ${data['product_price']}'),

                      Container(
                        // width: MediaQuery.of(context).size.width ,
                        height: 40,
                        margin: EdgeInsets.all(5),
                        child: RoundedButton(
                          btnName: "ProductDeatils",
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(data: data),
                              ),
                            );
                          },
                          bgColor: Color(0xFF0D4619),
                          textStyle: TextStyle(fontFamily: AutofillHints.givenName),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),

    );
  }
}