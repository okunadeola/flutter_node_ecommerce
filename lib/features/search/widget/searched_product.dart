import 'package:ecom/common/widgets/stars.dart';
import 'package:ecom/features/cart/services/cart_services.dart';
import 'package:ecom/features/product_details/services/product_details_services.dart';
import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatefulWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SearchedProduct> createState() => _SearchedProductState();
}

class _SearchedProductState extends State<SearchedProduct> {
  ProductDetailsServices productDetailsServices = ProductDetailsServices();
  CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
    }
    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 0.2)
          ], color: Colors.white, borderRadius: BorderRadius.circular(6)),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 4, 6, 4),
                  padding: const EdgeInsets.all(8),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade400),
                  child: Image.network(
                    widget.product.images[0],
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.product.name,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Stars(
                            rating: avgRating,
                          ),
                        ),
                        const SizedBox(
                          child: Text(
                            'Eligible for FREE Shipping',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${widget.product.price}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black12,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            increaseQuantity(widget.product),
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.symmetric(
        //     horizontal: 10,
        //   ),
        //   child: Row(
        //     children: [
        //       Image.network(
        //         widget.product.images[0],
        //         fit: BoxFit.contain,
        //         height: 110,
        //         width: 135,
        //       ),
        //       Column(
        //         children: [
        //           Container(
        //             width: 225,
        //             padding: const EdgeInsets.symmetric(horizontal: 10),
        //             child: Text(
        //               widget.product.name,
        //               style: const TextStyle(
        //                 fontSize: 16,
        //               ),
        //               maxLines: 2,
        //             ),
        //           ),
        //           Container(
        //             width: 235,
        //             padding: const EdgeInsets.only(left: 10, top: 5),
        //             child: Stars(
        //               rating: avgRating,
        //             ),
        //           ),
        //           Container(
        //             width: 235,
        //             padding: const EdgeInsets.only(left: 10, top: 5),
        //             child: Text(
        //               '\$${widget.product.price}',
        //               style: const TextStyle(
        //                 fontSize: 20,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //               maxLines: 2,
        //             ),
        //           ),
        //           Container(
        //             width: 235,
        //             padding: const EdgeInsets.only(left: 10),
        //             child: const Text('Eligible for FREE Shipping'),
        //           ),
        //           Container(
        //             width: 235,
        //             padding: const EdgeInsets.only(left: 10, top: 5),
        //             child: const Text(
        //               'In Stock',
        //               style: TextStyle(
        //                 color: Colors.teal,
        //               ),
        //               maxLines: 2,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
