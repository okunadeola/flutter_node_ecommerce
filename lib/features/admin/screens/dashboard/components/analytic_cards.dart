// ignore_for_file: avoid_print

import 'package:ecom/features/admin/models/analytic_info_model.dart';
import 'package:ecom/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/responsive.dart';
import '../data/data.dart';
import 'analytic_info_card.dart';

class AnalyticCards extends StatefulWidget {
  const AnalyticCards({Key? key}) : super(key: key);

  @override
  State<AnalyticCards> createState() => _AnalyticCardsState();
}

class _AnalyticCardsState extends State<AnalyticCards> {
  List<AnalyticInfo> analytics = [];
  
 final AdminServices _adminServices = AdminServices();


@override
void initState() {
  super.initState();
  fetchAnalytics();
  
  
}


fetchAnalytics() async{
       var incomingValue = await  _adminServices.fetchQuickAnalytics(context);
         List<AnalyticInfo>  copiedValue = [...analyticData];

      // // //  incomingValue.
      for (var i = 0; i < copiedValue.length; i++) {
        copiedValue[i].count = incomingValue[i];
      }

      setState(() {
        analytics = copiedValue;
      });

}






  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      child: Responsive(
        mobile: AnalyticInfoCardGridView(
          crossAxisCount: size.width < 650 ? 2 : 4,
          childAspectRatio: size.width < 650 ? 2 : 1.5,
        ),
        tablet: AnalyticInfoCardGridView(),
        desktop: AnalyticInfoCardGridView(
          childAspectRatio: size.width < 1400 ? 1.5 : 2.1,
        ),
      ),
    );
  }
}

class AnalyticInfoCardGridView extends StatelessWidget {
  const AnalyticInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1.4,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: analyticData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: appPadding,
        mainAxisSpacing: appPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => AnalyticInfoCard(
        info: analyticData[index],
      ),
    );
  }
}
