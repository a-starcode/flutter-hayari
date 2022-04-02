import 'package:flutter/material.dart';
import 'package:mad_project/constants.dart';
import 'package:mad_project/screens/product_page.dart';

class ProductCard extends StatelessWidget {
  final String? productId;
  final String? title;
  final String? imageUrl;
  final String? price;
  final VoidCallback? onPressed;

  const ProductCard({Key? key, this.productId, this.title, this.imageUrl, this.price, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              productId: productId,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Column(
          children: [
            Image.network(
              "$imageUrl",
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$title",
                    style: Constants.regularHeading,
                  ),
                  Text(
                    "\$$price",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Constants.primaryAccentColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
