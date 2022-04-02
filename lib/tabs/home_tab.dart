import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/screens/product_page.dart';
import 'package:mad_project/widgets/custom_action_bar.dart';
import 'package:mad_project/widgets/product_cart.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<QuerySnapshot>(
          future: _productsRef.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                padding: const EdgeInsets.only(
                  top: 106.0,
                  bottom: 24.0,
                ),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return ProductCard(
                    title: document['name'],
                    imageUrl: document['images'][0],
                    price: "${document['price']}",
                    productId: document.id,
                  );
                  // return Container(child: Text("${document.data['name']}"));
                }).toList(),
              );
            }

            return const Scaffold(
                body: Center(
              // child: CircularProgressIndicator(),
              child: Text("Done"),
            ));
          },
        ),
        CustomActionBar(
          title: "Home",
        ),
      ],
    );
  }
}
