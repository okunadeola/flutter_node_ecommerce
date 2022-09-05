import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/features/auth/services/auth_service.dart';
import 'package:ecom/features/home/screens/filter_screen.dart';
import 'package:ecom/features/home/services/home_services.dart';
import 'package:ecom/features/home/widgets/address_box.dart';
import 'package:ecom/features/home/widgets/carousel_image.dart';
import 'package:ecom/features/home/widgets/deal_of_day.dart';
import 'package:ecom/features/home/widgets/top_categories.dart';
import 'package:ecom/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {  
    super.initState();
    AuthService().updateUserToken(context: context);
  }




  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: {"searchQuery": query});
  }

  void goToFilterPage() {
    Navigator.pushNamed(context, FilterProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Ecom',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  icon: const Icon(Icons.filter_list_outlined,
                      color: Colors.black, size: 25),
                  onPressed: goToFilterPage,
                ),
              ),
            ],
          ),
        ),
      ),
      
      
      
      
      
      
      
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AddressBox(),
              const SizedBox(height: 10),
              TopCategories(
                selectCat: () {},
              ),
              const SizedBox(height: 10),
              const CarouselImage(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(child: Text('Deal of the day')),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, child: DealOfDay()),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(child: Text('Featured Products')),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: FeaturedProduct(),
              ),
              //  const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}


class FeaturedProduct extends StatefulWidget {
  const FeaturedProduct({Key? key}) : super(key: key);

  @override
  State<FeaturedProduct> createState() => _FeaturedProductState();
}

class _FeaturedProductState extends State<FeaturedProduct> {
  List<Product> _featuredProduct = [];
  final _homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    getFeaturedProduct();
  }

  getFeaturedProduct() async{
     var res = await _homeServices.fetchFeaturedProducts(context: context);
     setState(() {
       _featuredProduct = res;
     });
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
              children: [
                ...List.generate(
                  _featuredProduct.length,
                  (index) {
                    if (_featuredProduct[index].feature) {
                      return ProductCard(product: _featuredProduct[index]);
                    }
        
                    return const SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
    );
    
    
    //  GridView.builder(
    //   scrollDirection: Axis.horizontal,
    //   shrinkWrap: true,
    //   physics: const BouncingScrollPhysics(),
    //   itemCount: _featuredProduct.length ,
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //    itemBuilder:  (context, index){
    //   return SingleProduct(product: _featuredProduct[index],);
    // });
  }
}