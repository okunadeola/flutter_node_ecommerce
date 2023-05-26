// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:ecom/common/widgets/bottom_bar.dart';
import 'package:ecom/constants/error_handling.dart';
import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/constants/utils.dart';
import 'package:ecom/features/admin/screens/admin_screen.dart';
import 'package:ecom/features/admin/screens/dashboard/dashboard_screen.dart';
import 'package:ecom/models/user.dart';
import 'package:ecom/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';


class AuthService {
  // sign up user
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*"
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
            Colors.green
          );
        },
      );
    } catch (e) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
           showSnackBar(context, e.toString());
        });
    }
  }

  // sign in user
  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*"
        },
      );
      print('$uri/api/signin');

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            if (Provider.of<UserProvider>(context, listen: false)
                .user
                .token
                .isNotEmpty) {
              Provider.of<UserProvider>(context, listen: false).user.type ==
                      'user'
                  ? Navigator.pushNamedAndRemoveUntil(
                      context,
                      BottomBar.routeName,
                      (route) => false,
                    )
                  : Navigator.pushNamedAndRemoveUntil(
                      context,
                      DashBoardScreen.routeName,
                      (route) => false,
                    );
            }
          });
    } catch (e) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
            print("here2");
            showSnackBar(context, 'something went wrong');
        });
    }
  }

  // update user token
  void updateUserToken({
    required BuildContext context,
  }) async {
    try {
      final userData = Provider.of<UserProvider>(context, listen: false);
        print(userData.deviceToken);      
      http.Response res = await http.put(
        Uri.parse('$uri/api/user/save/token/${userData.user.id}'),
        body: jsonEncode({
          'tokenId': userData.deviceToken,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Access-Control-Allow-Origin": "*",
          'x-auth-token': userData.user.token,
        },
      );

      httpErrorHandle(
          response: res,
          context: context,                 
          onSuccess: () async {
            
          });
    } catch (e) {
       SchedulerBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, e.toString());
        });
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
          "Access-Control-Allow-Origin": "*"
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
            "Access-Control-Allow-Origin": "*"
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, e.toString());
        });
    }
  }
}
