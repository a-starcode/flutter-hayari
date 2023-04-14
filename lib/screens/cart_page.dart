import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/screens/product_page.dart';
import 'package:mad_project/services/firebase_services.dart';
import 'package:mad_project/widgets/custom_action_bar.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  var _cart_total = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserId())
                .collection("Cart")
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    top: 132.0,
                    bottom: 24.0,
                  ),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              productId: document.id,
                            ),
                          ),
                        );
                      },
                      child: FutureBuilder<DocumentSnapshot>(
                          future: _firebaseServices.productsRef
                              .doc(document.id)
                              .get(),
                          builder: (
                            context,
                            AsyncSnapshot<DocumentSnapshot> productsSnapshot,
                          ) {
                            if (productsSnapshot.hasError) {
                              return Scaffold(
                                body: Center(
                                  child:
                                      Text("Error: ${productsSnapshot.error}"),
                                ),
                              );
                            }
                            if (productsSnapshot.connectionState ==
                                ConnectionState.done) {
                              Map _productsMap =
                                  productsSnapshot.data!.data() as Map;

                              _cart_total += _productsMap['price'];
                              print(_cart_total);

                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 24.0,
                                  bottom: 16.0,
                                  left: 24.0,
                                  right: 24.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120.0,
                                      height: 120.0,
                                      child: Image.network(
                                        "${_productsMap['images'][0]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 16.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_productsMap['name']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 4.0,
                                            ),
                                            child: Text(
                                              "\$${_productsMap['price']}",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Constants
                                                    .primaryAccentColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Size - ${document['size']}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
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
            title: "Cart",
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
