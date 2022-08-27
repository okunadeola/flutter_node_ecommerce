

import 'package:ecom/features/product_details/services/product_details_services.dart';
import 'package:flutter/material.dart';

import 'package:ecom/models/product.dart';

class SingleProduct extends StatefulWidget {
  final Product product;
  const SingleProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  addToCart() {
    ProductDetailsServices()
        .addToCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 250, maxWidth: 150),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 221, 220, 220),
                spreadRadius: 0.3,
                blurRadius: 5.0)
          ],
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.all(6),
                child: Hero(
                  tag: widget.product.id.toString(),
                  child: Image.network(
                    widget.product.images[0],
                    fit: BoxFit.contain,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          Container(
            height: 20,
            width: 50,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.redAccent),
            child: const FittedBox(
                child: Text(
              'Disc 40%',
              style: TextStyle(fontSize: 10, color: Colors.white),
            )),
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            child: Text(
              widget.product.name,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          // const SizedBox(
          //   child: Text("5 Star",
          //       style: TextStyle(fontSize: 9, color: Colors.black)),
          // ),
          const SizedBox(
            height: 1,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${widget.product.price.toString()}',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                InkWell(
                  onTap: addToCart,
                  child: Container(

                    height: 35,
                    width: 32,
                     decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 87, 190, 94),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );

    // Container(
    //   height: 220,
    //   width: 140,
    //   padding: const EdgeInsets.all(5),
    //   decoration: BoxDecoration(
    //     boxShadow: const [
    //       BoxShadow(
    //           color: Color.fromARGB(255, 221, 220, 220),
    //           spreadRadius: 0.3,
    //           blurRadius: 5.0)
    //     ],
    //     color: Colors.white70,
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //     SizedBox(
    //       height: double.infinity / 2,
    //       width: double.infinity,
    //       child: Container(
    //           margin: const EdgeInsets.only(bottom: 5),
    //           child: Image.network(
    //             widget.product.images[0],
    //             fit: BoxFit.contain,
    //           ),
    //           decoration: BoxDecoration(
    //             color: Colors.grey.shade300,
    //             borderRadius: BorderRadius.circular(10),
    //           )),
    //     ),
    //     Container(
    //       height: 20,
    //       width: 50,
    //       padding: const EdgeInsets.all(5),
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(40), color: Colors.redAccent),
    //       child: const FittedBox(
    //           child: Text(
    //         'Disc 40%',
    //         style: TextStyle(fontSize: 10, color: Colors.white),
    //       )),
    //     ),
    //     const SizedBox(
    //       height: 4,
    //     ),
    //     SizedBox(
    //       child: Text(
    //         widget.product.name,
    //         style: const TextStyle(
    //             fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
    //         overflow: TextOverflow.ellipsis,
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 4,
    //     ),
    //     const SizedBox(
    //       child: Text("5 Star",
    //           style: TextStyle(fontSize: 9, color: Colors.black)),
    //     ),
    //     const SizedBox(
    //       height: 1,
    //     ),
    //     SizedBox(
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(widget.product.price.toString(),
    //               style: const TextStyle(
    //                   fontSize: 20,
    //                   color: Colors.black,
    //                   fontWeight: FontWeight.bold)),
    //           InkWell(
    //             onTap: () {},
    //             child: Container(
    //               height: 30,
    //               width: 30,
    //               decoration: BoxDecoration(
    //                 color: const Color.fromARGB(255, 87, 190, 94),
    //                 borderRadius: BorderRadius.circular(5),
    //               ),
    //               child: const Icon(
    //                 Icons.add,
    //                 color: Colors.white,
    //                 size: 15,
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ]),
    // );
  }
}
