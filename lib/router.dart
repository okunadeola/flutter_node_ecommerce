// ignore_for_file: avoid_print

import 'package:ecom/common/widgets/bottom_bar.dart';
import 'package:ecom/features/address/screens/address_screen.dart';
import 'package:ecom/features/admin/screens/add_product_screen.dart';
import 'package:ecom/features/admin/screens/admin_screen.dart';
import 'package:ecom/features/admin/screens/dashboard/dashboard_screen.dart';
import 'package:ecom/features/auth/screens/auth_screen.dart';
import 'package:ecom/features/auth/screens/login_screen.dart';
import 'package:ecom/features/auth/screens/register_screen.dart';
import 'package:ecom/features/cart/screens/cart_screen.dart';
import 'package:ecom/features/home/screens/category_deals_screen.dart';
import 'package:ecom/features/home/screens/filter_screen.dart';
import 'package:ecom/features/home/screens/home_screen.dart';
import 'package:ecom/features/order_details/screens/order_details.dart';
import 'package:ecom/features/product_details/screens/product_details_screen.dart';
import 'package:ecom/features/search/screens/search_screen.dart';
import 'package:ecom/models/order.dart';
import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case RegisterScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegisterScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
         var data = routeSettings.arguments as Product ?;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddProductScreen(productEdit: data,),
      );
    case CartScreen.routname:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );
    case FilterProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FilterProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var data = routeSettings.arguments as Map;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: data['searchQuery'],
          theProduct: data['theProducts'],
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var data = routeSettings.arguments as Map;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
            totalAmount: data['totalAmount'],
            isSingle: data['isSingle'],
            product: data['product'],
            quantity: data['quantity']),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case DashBoardScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DashBoardScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
