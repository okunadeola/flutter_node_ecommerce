import 'package:ecom/common/widgets/loader.dart';
import 'package:ecom/features/account/widgets/single_product.dart';
import 'package:ecom/features/admin/services/admin_services.dart';
import 'package:ecom/features/order_details/screens/order_details.dart';
import 'package:ecom/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    if (mounted) {
       setState(() {});  
      
    }
  }

  @override
  Widget build(BuildContext context) {
    if (orders == null) {
      return const Loader();
    } else {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: orders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10, crossAxisCount: 2),
              itemBuilder: (context, index) {
                final orderData = orders![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailScreen.routeName,
                      arguments: orderData,
                    ).then((value) => fetchOrders());
                  },
                  child: SizedBox(
                    height: 150,
                    child: SingleProduct(
                      key: ValueKey(orderData.products[0].id),
                      image: orderData.products[0].images[0],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
