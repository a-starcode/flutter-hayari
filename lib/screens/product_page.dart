import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/services/firebase_services.dart';
import 'package:mad_project/widgets/custom_action_bar.dart';
import 'package:mad_project/widgets/image_swipe.dart';
import 'package:mad_project/widgets/product_size.dart';

class ProductPage extends StatefulWidget {
  final String? productId;

  const ProductPage({Key? key, this.productId}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = "0";

  Future _addToCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  Future _addToFavorites() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Favorites")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  final SnackBar _snackBar = SnackBar(content: Text("Product added to cart!"),);
  final SnackBar _snackBarFav = SnackBar(content: Text("Product added to favorites!"),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
          future: _firebaseServices.productsRef.doc(widget.productId).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> documentData =
                  snapshot.data!.data() as Map<String, dynamic>;

              List imageList = documentData['images'];
              List productSizes = documentData['sizes'];

              // initial size
              _selectedProductSize = productSizes[0];

              return ListView(
                padding: EdgeInsets.only(
                  top: 134.0,
                ),
                children: [
                  ImageSwipe(
                    imageList: imageList,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 4.0,
                      left: 24.0,
                      right: 24.0,
                    ),
                    child: Text(
                      "${documentData['name']}",
                      style: Constants.boldHeading,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      "\$${documentData['price']}",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Constants.primaryAccentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "${documentData['description']}",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 24.0,
                    ),
                    child: Text(
                      "Select Size",
                      style: Constants.regularDarkText,
                    ),
                  ),
                  ProductSize(
                    productSizes: productSizes,
                    onSelected: (currentProductSize) {
                      _selectedProductSize = currentProductSize;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _addToFavorites();
                            ScaffoldMessenger.of(context).showSnackBar(_snackBarFav);
                          },
                          child: Container(
                            width: 65.0,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: Constants.greyAccentColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage("assets/images/nav_heart.png"),
                              width: 24.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await _addToCart();
                              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                            },
                            child: Container(
                              height: 65.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              margin: EdgeInsets.only(
                                left: 16.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
          hasBackArrow: true,
        )
      ],
    ));
  }
}
