import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';

class BottomNavbar extends StatefulWidget {
  final int? selectedTab;
  final Function(int)? tabPressed; 

  const BottomNavbar({Key? key, this.selectedTab, this.tabPressed}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 1.0,
            blurRadius: 30.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavbarBtn(
            imagePath: "assets/images/nav_home.png",
            isSelected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed!(0);
            },
          ),
          BottomNavbarBtn(
            imagePath: "assets/images/nav_search.png",
             isSelected: _selectedTab == 1 ? true : false,
             onPressed: () {
              widget.tabPressed!(1);
            },
          ),
          BottomNavbarBtn(
            imagePath: "assets/images/nav_heart.png",
             isSelected: _selectedTab == 2 ? true : false,
             onPressed: () {
              widget.tabPressed!(2);
            },
          ),
          BottomNavbarBtn(
            imagePath: "assets/images/nav_logout.png",
             isSelected: _selectedTab == 3 ? true : false,
             onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavbarBtn extends StatelessWidget {
  final String? imagePath;
  final bool? isSelected;
  final VoidCallback? onPressed;

  const BottomNavbarBtn({Key? key, this.imagePath, this.isSelected, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isSelected = isSelected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 18.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color:
                  _isSelected ? Constants.primaryAccentColor : Colors.transparent,
              width: 2.4,
            ),
          ),
        ),
        child: Image(
          width: 24.0,
          height: 24.0,
          color: _isSelected ? Constants.primaryAccentColor : Colors.black,
          image: AssetImage(imagePath ?? "/assets/images/nav_home.png"),
        ),
      ),
    );
  }
}
