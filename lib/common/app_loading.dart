import 'package:flutter/material.dart';

// AppLoading.showLoadingDialog(context);
class AppLoading {
  static final AppLoading _instance =  AppLoading.internal();
  static bool _isLoading = false;

  AppLoading.internal();

  factory AppLoading() => _instance;
  static BuildContext? _context;

  static void closeLoadingDialog() {
    if (_isLoading) {
      Navigator.of(_context!).pop();
      _isLoading = false;
    }
  }

  static void showLoadingDialog(BuildContext context) async {
    _context = context;
    _isLoading = true;
    await showDialog(
        context: _context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: RefreshProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                ),
              )
            ],
          );
        });
  }
}
