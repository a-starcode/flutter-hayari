import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';

class ProductSize extends StatefulWidget {
  final List? productSizes;
  final Function(String)? onSelected;
  const ProductSize({Key? key, this.productSizes, this.onSelected}) : super(key: key);

  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSizes!.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected!("${widget.productSizes![i]}");
                setState(() {
                  _selectedSize = i;
                });
              },
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: _selectedSize == i ? Constants.primaryAccentColor : Constants.greyAccentColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text(
                  "${widget.productSizes![i]}",
                  style: TextStyle(
                    color: _selectedSize == i ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
