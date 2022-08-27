import 'package:ecom/common/widgets/loader.dart';
import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/features/account/services/account_services.dart';
import 'package:ecom/features/account/widgets/single_product.dart';
import 'package:ecom/features/order_details/screens/order_details.dart';
import 'package:ecom/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order> orders = [];

  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders.isEmpty
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              // display orders
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        OrderDetailScreen.routeName,
                        arguments: orders[index],
                      );
                    },
                    child: OrderProduct(order: orders[index])
                    
                  );
                },
              ),
            ],
          );
  }
}


enum Track {
  pending,
  completed,
  delivered
}

class OrderProduct extends StatelessWidget {
  const OrderProduct({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
     Track track = (order.status == 1 || order.status == 0 )? Track.pending : order.status == 2 ?  Track.completed : Track.delivered; 
    var format = DateFormat.MMMEd();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card(
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200]
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                     Hero(
                  tag: order.id,                          
                  child: Image.network(order.products[0].images[0], width: 80, fit: BoxFit.contain, )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.products[0].name, style:  Theme.of(context).textTheme.headline6,),
                      Text("\$${order.totalPrice.toString()}"),
           
                      Text(format.format(DateTime.fromMillisecondsSinceEpoch(order.orderedAt))),
                      Card(
                        color: track == Track.pending ? Colors.grey : track == Track.completed ? Colors.blueAccent[100] : Colors.greenAccent  ,
                        child: Padding(
                          padding: const EdgeInsets.symmetric( vertical:4.0, horizontal: 8.0),
                          child: Text((order.status == 1 || order.status == 0)? 'Pending' : order.status == 2 ? 'Completed' : 'Deleverd' ,),
                        ))


                    ],),
                  )
                  ],
                  
                  )
                ],
              ),
            )
            
            
          
          ),
        ),
      ),
    );
  }
}
