import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/constants/utils.dart';
import 'package:ecom/features/account/services/account_services.dart';
import 'package:ecom/features/account/widgets/below_app_bar.dart';
import 'package:ecom/features/account/widgets/orders.dart';
import 'package:ecom/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:overlay_support/overlay_support.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
            // title: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       alignment: Alignment.topLeft,
            //       child: Image.asset(
            //         'assets/images/amazon_in.png',
            //         width: 120,
            //         height: 45,
            //         color: Colors.black,
            //       ),
            //     ),
            //     Container(
            //       padding: const EdgeInsets.only(left: 15, right: 15),
            //       child: Row(
            //         children: const [
            //           Padding(
            //             padding: EdgeInsets.only(right: 15),
            //             child: Icon(Icons.notifications_outlined),
            //           ),
            //           Icon(
            //             Icons.search,
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              BelowAppBar(),
              SizedBox(height: 10),
              TopButtons(),
              SizedBox(height: 20),
              AccountUser(),
              SizedBox(height: 40),
              SizedBox(height: 20),
              Orders(),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountUser extends StatefulWidget {
  const AccountUser({Key? key}) : super(key: key);

  @override
  State<AccountUser> createState() => _AccountUserState();
}

class _AccountUserState extends State<AccountUser> {
  AccountServices _accountServices = AccountServices();
  TextEditingController _controller = TextEditingController();
    var text = '';





  deleteAccount(BuildContext context) async {
    if (text.isNotEmpty && text == "DELETE MY ACCOUNT") {
        EasyLoading.show(status: "Loading...");
      await  _accountServices.deleteAccount(context: context);
      EasyLoading.dismiss();
      
    }else{
      print( text);
      toast("Enter words as shown");
    }
  }

  showWarning(BuildContext context) async {
      TextEditingController _controller = TextEditingController();
    await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
                
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 80,
                  height: 5,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Type in'),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'DELETE MY ACCOUNT',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height:3,
                ),
                TextField(
                  controller: _controller,
                  onChanged: (val){
                    setState(() {
                      text = val;
                    });
                  },
                  decoration: const InputDecoration(labelText: "enter letter"),
                ),
                const SizedBox(
                  height: 7,
                ),
                ElevatedButton(
                    onPressed:
                    () => deleteAccount(context),
                    //  (){
                    //   print(_controller.text);
                    //   print(text);
                    // },
                    
                    // _controller.text == "DELETE MY ACCOUNT"
                    //     ? () => deleteAccount(context)
                    //     : null,
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red),
                    child: const Text('Delete Account')),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        backgroundColor: Colors.grey,
        title: const Text('Account'),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => showWarning(context),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red),
                child: const Text('Delete Account')),
          ),
        ]);
  }
}
