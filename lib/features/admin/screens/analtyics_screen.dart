import 'package:ecom/common/widgets/loader.dart';
import 'package:ecom/features/admin/models/sales.dart';
import 'package:ecom/features/admin/services/admin_services.dart';
import 'package:ecom/features/admin/widgets/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Card(
            elevation: 0.5,
            color: Colors.white,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Sales',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 250,
                        child: CategoryProductsChart(seriesList: [
                          charts.Series(
                            id: 'Sales',
                            data: earnings!,
                            domainFn: (Sales  sales, _) => sales.label,
                            measureFn: (Sales sales, _) => sales.earning,
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
            ),
          ),
        );
  }
}
