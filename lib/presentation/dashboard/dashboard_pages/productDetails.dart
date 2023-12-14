import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/rounded_btn.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic>? data;
  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {


  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details Page"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Show the image or a placeholder icon if the image URL is null
                widget.data?['product_image'] != null
                    ? Image.network(
                  widget.data?['product_image'] ??'',
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                )
                    : Icon(Icons.image, size: 100),

                SizedBox(height: 16),
                Text(widget.data?['product_title'] ?? 'Placeholder Title',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Text(widget.data?['product_desc'] ?? 'Placeholder Description'),
                ),
                SizedBox(height: 2),
                Container(
                  margin: EdgeInsets.all(2),
                  child: Text('Rs: ${widget.data?['product_price'] ?? 0}'),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                        });
                      },
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: 40,
                  margin: EdgeInsets.all(5),
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.all(5),
                    child: RoundedButton(
                      btnName: "Buy Now",
                      callback: () async {
                        // Ensure that the user is logged in
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          try {
                            // Store order details in Firestore
                            await FirebaseFirestore.instance.collection('orders').add({
                              'user_id': user.uid,
                              'product_title': widget.data?['product_title'],
                              'product_desc': widget.data?['product_desc'] ?? '',
                              'product_price': widget.data?['product_price'],
                              'product_image': widget.data?['product_image'],
                              'quantity': quantity,
                              'timestamp': FieldValue.serverTimestamp(),
                              // Add other necessary details
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Item purchased successfully!')),
                            );

                            // Navigate to the order list page
                            // Navigator.push(context, );
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to purchase item: $error')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User is not logged in.')),
                          );
                        }
                      },
                      bgColor: Color(0xFF0D4619),
                      textStyle: TextStyle(fontFamily: AutofillHints.givenName),
                    ),
                  ),
                ),
                  ],

                ),
        ),
      ),
    ),
    );
  }
}
