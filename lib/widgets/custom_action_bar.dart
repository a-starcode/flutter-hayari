import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/screens/cart_page.dart';
import 'package:mad_project/services/firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackArrow;
  final bool? hasTitle;

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference? _usersRef =
      FirebaseFirestore.instance.collection("Users");

  CustomActionBar({Key? key, this.title, this.hasBackArrow, this.hasTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;

    return Container(
      padding: const EdgeInsets.only(
        top: 72.0,
        left: 24.0,
        right: 24.0,
        bottom: 18.0,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Constants.backBtnColor,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                child: Image(
                  image: AssetImage(
                    "assets/images/back_arrow.png",
                  ),
                  width: 20.0,
                  height: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? "Action bar",
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Constants.primaryAccentColor,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                child: StreamBuilder(
                    stream: _usersRef!
                        .doc(_firebaseServices.getUserId())
                        .collection("Cart")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      int _totalItems = 0;

                      if (snapshot.connectionState == ConnectionState.active) {
                        List<dynamic> _documents = snapshot.data!.docs;
                        _totalItems = _documents.length;
                      }

                      return Text(
                        "$_totalItems",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }
}
