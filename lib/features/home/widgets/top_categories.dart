// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/features/home/screens/category_deals_screen.dart';

class TopCategories extends StatefulWidget {
  final bool isFilter;
  final Function selectCat;
  final int reset;
  const TopCategories({
    Key? key,
    this.isFilter = false,
    this.reset = 0,
    required this.selectCat,
  }) : super(key: key);

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  String selectedCat = '';

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  triggerFilter(String s) {
    selectedCat = s;
    widget.selectCat(s);
    setState(() {});
  }

  changeUi() {
    setState(() {
      selectedCat = '';
    });
  }

  @override
  void didUpdateWidget(TopCategories oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reset != oldWidget.reset) {
      changeUi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 90,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: widget.isFilter
                ? () => triggerFilter(
                    GlobalVariables.categoryImages[index]['title']!)
                : () => navigateToCategoryPage(
                      context,
                      GlobalVariables.categoryImages[index]['title']!,
                    ),
            child: Container(
              width: 20,
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selectedCat ==
                          GlobalVariables.categoryImages[index]['title']!
                      ? GlobalVariables.selectedNavBarColor
                      : const Color.fromARGB(255, 235, 242, 243)),
              child: Column(
                children: [
                  SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedCat ==
                              GlobalVariables.categoryImages[index]['title']!
                          ? Colors.white
                          : Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
