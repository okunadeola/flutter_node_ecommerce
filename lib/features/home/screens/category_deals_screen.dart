import 'package:ecom/common/widgets/loader.dart';
import 'package:ecom/constants/global_variables.dart';
// import 'package:ecom/features/account/widgets/single_product.dart';
import 'package:ecom/features/home/services/home_services.dart';
import 'package:ecom/features/home/widgets/single_product.dart';
import 'package:ecom/features/product_details/screens/product_details_screen.dart';
import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.category,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: productList!.isNotEmpty ? Text(
                    'Keep shopping for ${widget.category}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ) : Text(
                    'no record for ${widget.category} category yet, check back later',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: productList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: size <= 450
                              ? 250
                              : size >= 750
                                  ? 250
                                  : 250,
                          crossAxisCount: size <= 450
                              ? 2
                              : size >= 451
                                  ? 3
                                  : size >= 750
                                      ? 4
                                      : size >= 1000
                                          ? 6
                                          : 5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetailScreen.routeName,
                                arguments: product,
                              );
                            },
                            child: SingleProduct(product: product));
                      },
                    ),
                  ),

                  //  Padding(
                  //    padding: const EdgeInsets.all(8.0),
                  //    child: GridView(
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             mainAxisExtent: 258,
                  //             mainAxisSpacing: 10,
                  //             crossAxisSpacing: 10),
                  //       children: [
                  //         SingleProduct(product: Product(category: 'moblie', name: 'tech', description: 'cool', quantity: 5, images: [''], price:6 ) ,),
                  //         SingleProduct(product: Product(category: 'moblie', name: 'tech', description: 'cool', quantity: 5, images: [''], price:6 ) ,),
                  //         SingleProduct(product: Product(category: 'moblie', name: 'tech', description: 'cool', quantity: 5, images: [''], price:6 ) ,),
                  //         SingleProduct(product: Product(category: 'moblie', name: 'tech', description: 'cool', quantity: 5, images: [''], price:6 ) ,),
                  //         SingleProduct(product: Product(category: 'moblie', name: 'tech', description: 'cool', quantity: 5, images: [''], price:6 ) ,),
                  //         SingleProduct(product: Product(category: 'moblie', name: 'tech', description: 'cool', quantity: 5, images: [''], price:6 ) ,),
                  //         SingleProduct(product: Product(category: 'moblie', name: 'tech', description: 'cool', quantity: 5, images: [''], price:6 ) ,),
                  //         SingleProduct(product: Product(category: 'moblie', name: 'tech', description: 'cool', quantity: 5, images: [''], price:6 ) ,),
                  //       ],
                  // ),
                  //  ),
                ),
              ],
            ),
    );
  }
}


 // GridView.builder(
//   scrollDirection: Axis.horizontal,
//   padding: const EdgeInsets.only(left: 15),
//   itemCount: productList!.length,
//   gridDelegate:
//       const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10),
//   itemBuilder: (context, index) {
//     final product = productList![index];
//     return GestureDetector(
//         onTap: () {
//           Navigator.pushNamed(
//             context,
//             ProductDetailScreen.routeName,
//             arguments: product,
//           );
//         },
//         child:SingleProduct(product: product)
//         );
//   },
// ),