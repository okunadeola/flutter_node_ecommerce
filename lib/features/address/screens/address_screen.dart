// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:ecom/common/widgets/bottom_bar.dart';
import 'package:ecom/features/home/screens/home_screen.dart';
import 'package:ecom/features/product_details/services/product_details_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:ecom/common/widgets/custom_button.dart';
import 'package:ecom/common/widgets/custom_textfield.dart';
import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/constants/utils.dart';
import 'package:ecom/features/address/services/address_services.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/providers/user_provider.dart';
import 'package:cool_alert/cool_alert.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  final bool isSingle;
  final Product? product;
  final int? quantity;

  const AddressScreen({
    Key? key,
    required this.totalAmount,
    required this.isSingle,
    this.product,
    this.quantity,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  String newAddressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    print(widget.isSingle);
    String formattedAmount = widget.totalAmount + "00";
    paymentItems.add(
      PaymentItem(
        amount: formattedAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void showSuccessAlert() {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "Your transaction was successful!",
        loopAnimation: true,
        onConfirmBtnTap:(){
         routeToHome(context);
        },
        barrierDismissible: false);
  }

  void routeToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, BottomBar.routeName, ((route) => false));
  }

  void showErrorAlert() {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: "Oops, Something went wrong!",
    );
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    newAddressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR  No address');
    }
  }

  Future<void> initPaymentSheet(context,
      {required String email, required String amount}) async {
    try {
      // print(amount);
      String formattedAmount = amount + "00";
      final response = await http.post(
          Uri.parse('https://paymentwithstripenode.herokuapp.com/api/payment'),
          body: {
            'email': email,
            'amount': (double.tryParse(formattedAmount)).toString()
          });

      final jsonResponse = jsonDecode(response.body);
    

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: jsonResponse['paymentIntent'],
              merchantDisplayName: "Flutter Stripe Store Demo",
              customerId: jsonResponse['customer'],
              customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
              style: ThemeMode.light,
              testEnv: true,
              merchantCountryCode: 'USD'));

      // await Stripe.instance.pre

      await Stripe.instance.presentPaymentSheet();
      payPressed(addressToBeUsed);
      if (Provider.of<UserProvider>(context, listen: false)
          .user
          .address
          .isEmpty) {
        addressServices.saveUserAddress(
            context: context, address: addressToBeUsed);
      }

      if (widget.isSingle) {
        ProductDetailsServices().buySingle(
            context: context,
            product: widget.product!,
            quantity: widget.quantity!,
            address: addressToBeUsed,
            totalSum: double.parse(widget.totalAmount));
      } else {
        addressServices.placeOrder(
          context: context,
          address: addressToBeUsed,
          totalSum: double.parse(widget.totalAmount),
        );
      }

      showSuccessAlert();
    } catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${e.error.localizedMessage}")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error $e")));
      }

      showErrorAlert();
    }
  }

  @override
  Widget build(BuildContext context) {
    addressToBeUsed = context.watch<UserProvider>().user.address;
    var user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text("Checkout"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'Destination',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    showModal(context);
                  },
                  child: Text(
                    addressToBeUsed.isEmpty ? "Add" : 'Change',
                    style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ]),

              const SizedBox(
                height: 10,
              ),

              addressToBeUsed.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(
                            child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              height: 80,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(Icons.location_on, size: 50, color: Colors.white,)
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    addressToBeUsed,
                                    maxLines: null,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Column(
                      children:  [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: 20,
                            child: Wrap(
                              children: const [Text(
                                "Please add your address to complete your order",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: TextStyle(color: Colors.grey),
                              ),]
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),

              Center(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sub Total Price",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text("\$${widget.totalAmount}")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Delivery Fee",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text("\$0.0")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text("\$${widget.totalAmount}")
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Builder(
                    builder: (context) {
                      return CustomButtons(
                        color: GlobalVariables.selectedNavBarColor,
                        disable: addressToBeUsed.isEmpty,
                        onTap: () async {
                          await initPaymentSheet(context,
                              email: user.email, amount: widget.totalAmount);
                        },
                        text: 'Pay Now',
                      );
                    }
                  ),
                ],
              )),

              // Platform.isIOS
              //     ? ApplePayButton(
              //         width: double.infinity,
              //         style: ApplePayButtonStyle.whiteOutline,
              //         type: ApplePayButtonType.buy,
              //         paymentConfigurationAsset: 'applepay.json',
              //         onPaymentResult: onApplePayResult,
              //         paymentItems: paymentItems,
              //         margin: const EdgeInsets.only(top: 15),
              //         height: 50,
              //         onPressed: () => payPressed(address),
              //       )
              //     : const SizedBox.shrink(),
              // const SizedBox(height: 10),
              // Platform.isAndroid
              //     ? GooglePayButton(
              //         onPressed: () => payPressed(address),
              //         paymentConfigurationAsset: 'gpay.json',
              //         onPaymentResult: onGooglePayResult,
              //         paymentItems: paymentItems,
              //         height: 50,
              //         style: GooglePayButtonStyle.black,
              //         type: GooglePayButtonType.buy,
              //         margin: const EdgeInsets.only(top: 15),
              //         loadingIndicator: const Center(
              //           child: CircularProgressIndicator(),
              //         ),
              //       )
              //     : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  showModal(BuildContext context) async {

    showMaterialModalBottomSheet(
      expand: true,
  context: context,
  builder: (context) {
      return SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child:  Column(          
              children: [
                const SizedBox(height: 20,),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _addressFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: flatBuildingController,
                          hintText: 'Flat, House no, Building',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: areaController,
                          hintText: 'Area, Street',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: pincodeController,
                          hintText: 'Pincode',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: cityController,
                          hintText: 'Town/City',
                        ),
                        const SizedBox(height: 10),
                        CustomButtons(
                          color: GlobalVariables.selectedNavBarColor,
                          onTap: submitAddress,
                          text: 'Set Address',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      );
  },
);










    // return await showModalBottomSheet(
    //     context: context,
    //     builder: (context) {
    //       return SingleChildScrollView(
    //         child: Column(          
    //           children: [
    //             Container(
    //               margin: const EdgeInsets.only(top: 8),
    //               padding: const EdgeInsets.all(8.0),
    //               child: Form(
    //                 key: _addressFormKey,
    //                 child: Column(
    //                   children: [
    //                     CustomTextField(
    //                       controller: flatBuildingController,
    //                       hintText: 'Flat, House no, Building',
    //                     ),
    //                     const SizedBox(height: 10),
    //                     CustomTextField(
    //                       controller: areaController,
    //                       hintText: 'Area, Street',
    //                     ),
    //                     const SizedBox(height: 10),
    //                     CustomTextField(
    //                       controller: pincodeController,
    //                       hintText: 'Pincode',
    //                     ),
    //                     const SizedBox(height: 10),
    //                     CustomTextField(
    //                       controller: cityController,
    //                       hintText: 'Town/City',
    //                     ),
    //                     const SizedBox(height: 10),
    //                     CustomButtons(
    //                       color: GlobalVariables.selectedNavBarColor,
    //                       onTap: submitAddress,
    //                       text: 'Set Address',
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     });
}

  void submitAddress() {
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm || _addressFormKey.currentState!.validate()) {
      if (_addressFormKey.currentState!.validate()) {
          addressToBeUsed =
              '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
        addressServices.saveUserAddress(
            context: context, address: addressToBeUsed);
        setState(() {});
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter all the values!'),
      ));
    }
  }
  }

