import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/services/firebase_services.dart';
import 'package:mad_project/widgets/custom_form_input.dart';
import 'package:mad_project/widgets/product_cart.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _firebaseServices = FirebaseServices();
    String _searchQuery = "Black Jeans";

    return Center(
      child: Container(
        child: Stack(
          children: [
            // if (_searchQuery.isEmpty)
            //   Center(
            //     child: Container(
            //       child: Text(
            //         "Search results",
            //         style: Constants.regularDarkText,
            //       ),
            //     ),
            //   )
            // else
              FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.productsRef.orderBy("name").startAt([_searchQuery]).endAt([_searchQuery]).get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        top: 126.0,
                        bottom: 24.0,
                      ),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
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
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: CustomFormInput(
                hintText: "Black Jeans",
                onSubmitted: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
