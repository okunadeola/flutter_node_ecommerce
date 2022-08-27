import 'package:ecom/constants/constants.dart';
import 'package:ecom/constants/responsive.dart';
import 'package:ecom/features/admin/screens/dashboard/components/profile_info.dart';
import 'package:ecom/features/admin/screens/dashboard/components/search_field.dart';
import 'package:ecom/features/admin/screens/dashboard/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              onPressed: context.read<Controller>().controlMenu,
              icon: Icon(Icons.menu,color: textColor.withOpacity(0.5),),
            ),
          const Expanded(child: SearchField()),
          const ProfileInfo()
        ],
      ),
    );
  }
}
