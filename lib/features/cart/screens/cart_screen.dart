// ignore_for_file: avoid_print

import 'package:ecom/common/widgets/custom_button.dart';
import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/features/address/screens/address_screen.dart';
import 'package:ecom/features/cart/services/cart_services.dart';
import 'package:ecom/features/cart/widgets/cart_product.dart';
import 'package:ecom/features/cart/widgets/cart_subtotal.dart';
import 'package:ecom/features/home/widgets/address_box.dart';
import 'package:ecom/features/search/screens/search_screen.dart';
import 'package:ecom/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routname = "/cart";
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartServices cartServices = CartServices();
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: {"searchQuery": query});
  }




  void navigateToAddress(int sum) {
    final args = {
      'totalAmount': sum.toString(),
      'isSingle': false,
      'product': null,
      'quantity': null
    };

    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: args,
    );
  }

    void removeProductFromCart(String id) {
    cartServices.removeProductFromCart(
      context: context,
      id: id,
    );
  }




  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search ecom..',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(Icons.mic, color: Colors.black, size: 25),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: user.cart.isEmpty ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text('You have no item in your cart, shop for goods!')),
          ) :Column(
            children: [
              const AddressBox(),
              const CartSubtotal(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButtons(
                  text: 'Checkout',
                  onTap: () => navigateToAddress(sum),
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1,
              ),
              const SizedBox(height: 5),
              ListView.builder(
                scrollDirection:Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(user.cart[index]['product']['_id']),
                    endActionPane: pane(user.cart[index]['product']),
                    child: CartProduct(
                      index: index,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ActionPane pane(data) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            removeProductFromCart(data["_id"]);
          },
          backgroundColor: const Color.fromARGB(255, 252, 121, 121),
          foregroundColor: Colors.white,
          borderRadius: BorderRadius.circular(30),
          icon: Icons.delete_outline,
          label: 'Delete',
        ),
      ],
    );
  }
}
