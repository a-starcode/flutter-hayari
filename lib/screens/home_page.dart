import 'package:flutter/material.dart';
import 'package:mad_project/tabs/favorites_tab.dart';
import 'package:mad_project/tabs/home_tab.dart';
import 'package:mad_project/tabs/search_tab.dart';
import 'package:mad_project/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _bottomTabsPageController;
  int _selectedPage = 0;

  @override
  void initState() {
    _bottomTabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _bottomTabsPageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _bottomTabsPageController,
                onPageChanged: (currentPageNumber) {
                  setState(() {
                    _selectedPage = currentPageNumber;
                  });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  FavoritesTab(),
                ],
              ),
            ),
            Container(
              child: BottomNavbar(
                selectedTab: _selectedPage,
                tabPressed: (currentPageNumber) {
                  setState(() {
                    _bottomTabsPageController!.animateToPage(
                      currentPageNumber,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                    );
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
