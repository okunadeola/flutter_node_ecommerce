import 'package:ecom/features/account/services/account_services.dart';
import 'package:ecom/features/admin/screens/dashboard/components/drawer_list_tile.dart';
import 'package:ecom/features/admin/screens/dashboard/controllers/controller.dart' as m;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecom/constants/constants.dart';


class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/ecom_logo.png", height: 100,),
          ),
          DrawerListTile(
              title: 'DashBoard',
              svgSrc: 'assets/icons/Dashboard.svg',
              tap: () {
                Provider.of<m.Controller>(context, listen: false)
                    .changeMenu(context,m.MenuItem.Dashboard);
              }),
          DrawerListTile(
              title: 'Product',
              svgSrc: 'assets/icons/BlogPost.svg',
              tap: () {
                Provider.of<m.Controller>(context, listen: false)
                    .changeMenu(context,m.MenuItem.Product);
              }),
          DrawerListTile(
              title: 'Customer',
              svgSrc: 'assets/icons/Message.svg',
              tap: () {
                Provider.of<m.Controller>(context, listen: false)
                    .changeMenu(context, m.MenuItem.Customer);
              }),
          DrawerListTile(
              title: 'Order',
              svgSrc: 'assets/icons/Statistics.svg',
              tap: () {
                Provider.of<m.Controller>(context, listen: false)
                    .changeMenu(context, m.MenuItem.Order);
              }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: appPadding * 2),
            child: Divider(
              color: grey,
              thickness: 0.2,
            
            ),
          ),
          DrawerListTile(
              title: 'Settings',
              svgSrc: 'assets/icons/Setting.svg',
              tap: () {}),
          DrawerListTile(
              title: 'Logout', svgSrc: 'assets/icons/Logout.svg', tap: () {
                        AccountServices().logOut(context);
              }),
        ],
      ),
    );
  }
}
