import 'package:ecom/features/admin/screens/dashboard/components/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom/constants/constants.dart';
import 'package:ecom/constants/responsive.dart';
import 'package:ecom/features/admin/screens/dashboard/controllers/controller.dart' as m;
import 'components/custom_appbar.dart';
import 'components/dashboard_content.dart';
import 'components/drawer_menu.dart';
import 'components/order_screen.dart';

class DashBoardScreen extends StatelessWidget {
  static const String routeName  = '/adminnew';
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      drawer: const DrawerMenu(),
      key: context.read<m.Controller>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: DrawerMenu(),
              ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomAppbar(),
                  Expanded(
                    child: Consumer<m.Controller>(
                      builder: (BuildContext context, value, Widget? child) {
                        if (value.selectedMenu == m.MenuItem.Dashboard) {
                          return const DashboardContent();
                        }
                        if (value.selectedMenu == m.MenuItem.Product) {
                          return const Paging();
                        }
                        if (value.selectedMenu == m.MenuItem.Customer) {
                          return Scaffold(
                            appBar: AppBar(title: const Text('Customer'),),
                          );
                        }
                        if (value.selectedMenu == m.MenuItem.Order) {
                          return const AdminOrder();
                        }
                        return Container();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
