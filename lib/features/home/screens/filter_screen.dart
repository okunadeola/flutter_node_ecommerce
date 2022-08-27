// ignore_for_file: avoid_print

import 'package:ecom/common/widgets/custom_button.dart';
import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/features/home/services/home_services.dart';
import 'package:ecom/features/home/widgets/top_categories.dart';
import 'package:ecom/features/search/screens/search_screen.dart';
import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';

class FilterProductScreen extends StatefulWidget {
  static const String routeName = "/filter";
  const FilterProductScreen({Key? key}) : super(key: key);

  @override
  State<FilterProductScreen> createState() => _FilterProductScreenState();
}

class _FilterProductScreenState extends State<FilterProductScreen> {
  RangeValues value = const RangeValues(0, 1000);
  int reset = 0;
  int selectedRate = 0;
  String selectedCat = '';
  int min = 0;
  int max = 0;

  selectCategory(returnedValue) {
    setState(() {
      selectedCat = returnedValue;
    });
  }

  applyFilter() async {

    print(max);
    print(min);
    print(selectedCat);
    print(selectedRate);
    List<Product> theProducts = await HomeServices().filterProduct(
        context: context,
        category: selectedCat,
        min: min,
        max: max,
        rating: selectedRate);
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: {"theProducts": theProducts, "searchQuery": ''});
  }

  clear() {
    setState(() {
      reset += 1;
      selectedCat = '';
      value = const RangeValues(1, 1000);
      selectedRate = 0;
      min = 0;
      max = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    RangeLabels label = RangeLabels(
        '\$${(value.start.toInt() * 10).toString()}',
        '\$${(value.end.toInt() * 10).toString()}');

    return Scaffold(
      backgroundColor: GlobalVariables.selectedNavBarColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: GlobalVariables.selectedNavBarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appBarWidget(
                onPressed: () => Navigator.pop(context),
                icon: Icons.arrow_back_ios_sharp,
              ),
              const SizedBox(child: Text('Filter')),
              appBarWidget(
                onPressed: clear,
                icon: Icons.replay_sharp,
              ),
            ],
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 30,
              ),
              TopCategories(
                  isFilter: true, selectCat: selectCategory, reset: reset),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Text("Pricing Range",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              RangeSlider(
                activeColor: GlobalVariables.selectedNavBarColor,
                values: value,
                labels: label,
                divisions: 20,
                min: 0,
                max: 1000,
                onChanged: (val) {
                  setState(() {
                    value = val;
                    min = value.start.toInt() * 10;
                    max = value.end.toInt() * 10;
                  
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Text("Rating",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(5, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedRate = index + 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Chip(
                              backgroundColor: selectedRate == index + 1
                                  ? GlobalVariables.selectedNavBarColor
                                  : null,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              label: Row(children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellowAccent,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                      color: selectedRate == index + 1
                                          ? Colors.white
                                          : Colors.black),
                                )
                              ]),
                            ),
                          ),
                        );
                      })),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButtons(
                  text: 'Apply',
                  onTap: applyFilter,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ]),
          )),
        ],
      ),
    );
  }

  Widget appBarWidget(
      {required VoidCallback onPressed, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70.withOpacity(.5),
      ),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 18,
            color: Colors.white,
          )),
    );
  }
}
