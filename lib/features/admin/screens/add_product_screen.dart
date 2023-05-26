import 'dart:io';

import 'package:ecom/common/widgets/custom_button.dart';
import 'package:ecom/common/widgets/custom_textfield.dart';
import 'package:ecom/constants/constants.dart';
import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/constants/utils.dart';
import 'package:ecom/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecom/models/product.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key, this.productEdit}) : super(key: key);
  final Product ? productEdit; 

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}






class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  bool feature = false;
  String editingProductId = '';

  String category = 'Mobiles';
  List<File> images = [];
  List<String> imageString = [];
  final _addProductFormKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    getValue();
  }



  getValue(){
    if (widget.productEdit != null) {
      var value = widget.productEdit;
      setState(() {
        imageString = value?.images ?? [];
        productNameController.text = value?.name ?? '';
        descriptionController.text = value?.description ?? '';
        priceController.text = value?.price.toString() ?? '';
        quantityController.text = value?.quantity.toString() ?? '';
        category = value?.category ?? category;
        feature = value?.feature ?? feature;
        editingProductId = value?.id ?? editingProductId;
      });
    }
  }



  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        feature:  feature,
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
        isEditing: false,
        imagesUrl: imageString
      );
    }
  }

  void editProduct() {
    if (_addProductFormKey.currentState!.validate() && imageString.isNotEmpty) {
      adminServices.editProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        feature:  feature,
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
        isEditing: true,
        imagesUrl: imageString,
        id: editingProductId
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Text(
              'Add Product',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  widget.productEdit != null ? CarouselSlider(
                          items: imageString.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.network(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        ) :
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: productNameController,
                    hintText: 'Product Name',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: 'Description',
                    maxLines: 7,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: priceController,
                    hintText: 'Price',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: quantityController,
                    hintText: 'Quantity',
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          category = newVal!;
                        });
                      },
                    ),
                  ),
                   const SizedBox(height: 10),
                  Card(
                    elevation: 3,
                    child: SwitchListTile.adaptive(
                      
                      title: const Text('Featured Product'),
                      subtitle: const Text('make as featured product'),
                      value: feature, onChanged: (value){
                      setState(() {
                        feature = value;
                      });
                    }),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    color: primaryColor,
                    text: widget.productEdit != null ? 'Edit'  : 'Sell',
                    onTap:  widget.productEdit != null ? editProduct :  sellProduct,
                  ),
                     const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
