// ignore_for_file: avoid_print

import 'package:ecom/common/widgets/custom_button.dart';
import 'package:ecom/common/widgets/stars.dart';
import 'package:ecom/features/address/screens/address_screen.dart';
import 'package:ecom/features/cart/screens/cart_screen.dart';
import 'package:ecom/features/cart/services/cart_services.dart';
import 'package:ecom/features/product_details/services/product_details_services.dart';
import 'package:ecom/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/features/search/screens/search_screen.dart';
import 'package:ecom/models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();
  double avgRating = 0;
  double myRating = 0;
  int cartLen = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToAddress(int sum) {
    final args = {
      'totalAmount': sum.toString(),
      'isSingle': true,
      'product': widget.product,
      'quantity': cartLen
    };

    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: args,
    );
  }

  void routeToCart(){
    Navigator.pushReplacementNamed(context, CartScreen.routname);
  }


  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context,
      product: widget.product,
    );
  }

  void removeFromCart() {
    cartLen > 0 ?
    cartServices.removeFromCart(
      context: context,
      product: widget.product,
    )  : null;
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart;
    try {
      final product = productCart.firstWhere(
          (element) => element["product"]["_id"] == widget.product.id, orElse: ()=> 0);
      setState(() {
        cartLen = product == 0 ? 0 : product['quantity'];
        print(cartLen);
      });
    } catch (e) {
      print(e);
    }

//  var data =  [
//   {product:
//     {
//       name: Tecno Camon,
//       description: clean mobile for the smart,
//        images: [https://res.cloudinary.com/denfgaxvg/image/upload/v1655999536/Tecno%20Camon/    qsratlhjmjltrp3yclv3.png],
//        quantity: 47,
//        price: 200,
//        category: Mobiles,
//        ratings: [{userId: 62b19994a249b23e858a5307, rating: 3, _id: 62b49143d0fbfca0dba57171}],
//        _id: 62b48c30d0fbfca0dba55a39, __v: 1},

//        quantity: 3,
//         _id: 62bafe5704657f4685443190}
//     ]

    // final productCart = context.watch<UserProvider>().user.cart[widget.index];
    // final product = Product.fromMap(productCart['product'][]);
    // final quantity = productCart['quantity'];

    // final user = context.watch<UserProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Text(
              widget.product.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
                child: IconButton(
                  onPressed: () {
                    routeToCart();
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 25,
                    color: GlobalVariables.backgroundColor,
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
              tag: widget.product.id.toString(),
                child: CarouselSlider(
                  items: widget.product.images.map(
                    (i) {
                      return Builder(
                        builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.contain,
                          height: 200,
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 300,
                  ),
                ),
              ),
              Container(
                color: Colors.black12,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite_border_outlined),
                            onPressed: () {},
                            color: GlobalVariables.selectedNavBarColor,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stars(
                          rating: avgRating,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: GlobalVariables.selectedNavBarColor
                                  .withOpacity(.1)),
                          child: Text(
                            '\$${widget.product.price}',
                            style: TextStyle(
                              fontSize: 18,
                              color: GlobalVariables.selectedNavBarColor
                                  .withOpacity(.9),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                cartButton(
                                  removeFromCart,
                                  Icons.remove,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: Colors.grey),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(scale: animation, child: child,);
                                    },
                                    child: Text(
                                      cartLen.toString(),
                                      key: ValueKey(cartLen.toString()),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                cartButton(
                                  addToCart,
                                  Icons.add,
                                )
                              ]),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 60,
                      child: Text(
                        widget.product.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // RatingBar.builder(
              //   initialRating: myRating,
              //   minRating: 1,
              //   direction: Axis.horizontal,
              //   allowHalfRating: true,
              //   itemCount: 5,
              //   itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              //   itemBuilder: (context, _) => const Icon(
              //     Icons.star,
              //     color: GlobalVariables.secondaryColor,
              //   ),
              //   onRatingUpdate: (rating) {
              //     productDetailsServices.rateProduct(
              //       context: context,
              //       product: widget.product,
              //       rating: rating,
              //     );
              //   },
              // )
            ],
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                // height: 45,
                // width: 43,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: GlobalVariables.selectedNavBarColor, width: 2)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: Colors.white,
                    shadowColor: Colors.white,
                    minimumSize: const Size(40, 45),
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: GlobalVariables.selectedNavBarColor,
                  ),
                  onPressed: addToCart,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: GlobalVariables.selectedNavBarColor,
                    minimumSize: const Size(170, 50),
                  ),
                  child: const Text('Buy Now'),
                  onPressed:cartLen == 0 ? null :  () {
                    if (cartLen > 0) {
                      final total = widget.product.price.toInt() * cartLen;
    
                      navigateToAddress(total);
                    }
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

Widget cartButton(
  VoidCallback onPress,
  IconData? icon,
) {
  return InkWell(
    onTap: onPress,
    child: Container(
      alignment: Alignment.center,
      height: 35,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        icon,
        color: Colors.grey.shade700,
        size: 15,
      ),
    ),
  );
}
