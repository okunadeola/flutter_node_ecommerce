import 'package:ecom/common/widgets/loader.dart';
import 'package:ecom/features/account/widgets/single_product.dart';
import 'package:ecom/features/admin/screens/add_product_screen.dart';
import 'package:ecom/features/admin/services/admin_services.dart';
import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();

    fetchAllProducts();
  }

  fetchAllProducts() async {
    if (mounted) {
      products = await adminServices.fetchAllProducts(context);
      setState(() {});
    }
  }

  void deleteProduct(Product product, int index) {
    // adminServices.deleteProduct(
    //   context: context,
    //   product: product,
    //   onSuccess: () {
    //     products!.removeAt(index);
    //     setState(() {});
    //   },
    // );
  }

  void navigateToAddProduct() async {
    Navigator.pushNamed(context, AddProductScreen.routeName).then(
      (value) => fetchAllProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
              child: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 2, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: SingleProduct(
                          image: productData.images[0],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () => deleteProduct(productData, index),
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
