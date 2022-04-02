import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List? imageList;

  const ImageSwipe({Key? key, this.imageList}) : super(key: key);

  @override
  State<ImageSwipe> createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (currentPageNumber) {
              setState(() {
                _selectedPage = currentPageNumber;
              });
            },
            children: [
              for (var i = 0; i < widget.imageList!.length; i++)
                Container(
                    child: Image.network(
                  "${widget.imageList![i]}",
                  fit: BoxFit.cover,
                ))
            ],
          ),
          Positioned(
            bottom: 14.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imageList!.length; i++)
                  AnimatedContainer(
                    duration: Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.easeInOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    width: _selectedPage == i ? 36.0 : 10.0,
                    height: 10.0,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
