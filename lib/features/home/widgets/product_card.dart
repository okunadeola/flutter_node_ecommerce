import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



import '../../../constants/constants.dart';
import '../../product_details/screens/product_details_screen.dart';



class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
   void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: widget.product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          width: widget.width,
          // height: 300,
          child: GestureDetector(
            onTap:navigateToDetailScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.02,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Hero(
                      tag: widget.product.id.toString(),
                      child: Image.network(widget.product.images[0]),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product.name,
                  style: const TextStyle(color: Colors.black),
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.product.price}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width:30,
                        decoration: BoxDecoration(
                          color: !widget.product.feature
                              ? kPrimaryColor.withOpacity(0.15)
                              : kSecondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.favorite, size: 18,
                          color: !widget.product.feature
                              ? const Color(0xFFFF4848)
                              : const Color(0xFFDBDEE4),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
