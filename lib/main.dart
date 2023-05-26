// ignore_for_file: avoid_print

import 'package:ecom/common/widgets/bottom_bar.dart';
import 'package:ecom/constants/global_variables.dart';
import 'package:ecom/features/admin/screens/admin_screen.dart';
import 'package:ecom/features/admin/screens/dashboard/controllers/controller.dart';
import 'package:ecom/features/admin/screens/dashboard/dashboard_screen.dart';
import 'package:ecom/features/auth/screens/auth_screen.dart';
import 'package:ecom/features/auth/screens/login_screen.dart';
import 'package:ecom/features/auth/services/auth_service.dart';
import 'package:ecom/features/cart/screens/cart_screen.dart';
import 'package:ecom/features/home/screens/filter_screen.dart';
import 'package:ecom/features/onboard/onboarding_screen.dart';
import 'package:ecom/notification/local_notification.dart';
import 'package:ecom/providers/user_provider.dart';
import 'package:ecom/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart'; 
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:overlay_support/overlay_support.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);    
} 



void main() async {
WidgetsFlutterBinding.ensureInitialized();
  // WidgetsBinding widgetsBinding =  
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  FlutterNativeSplash.remove();

  
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  if (Platform.isIOS || Platform.isAndroid) {
    Stripe.publishableKey =
        'pk_test_51JrmbwAVsqeK8xRiNB8yndW6TFCLTZmfblHL9uBcJWUB9HGWTU9mNsbNpdwoIqvwIkj3tuOXbCoOYp3A1RMuC4zs00joHB6Yx2';
    await Stripe.instance.applySettings();
  }


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(), 
    ),
    ChangeNotifierProvider(
      create: (context) => Controller(), 
    ),
  ], child: const MyApp()));
}
















class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    _saveDeviceToken();
    getNotification();
    reload();
    init();
  }

  init() async {
    await LocalNotification.initialize();  
  }

  reload() {
    if (mounted) {
    AuthService().getUserData(context);
    }
  }

  getNotification() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data['route'];
        print(routeFromMessage);
        _navKey.currentState?.pushNamed(routeFromMessage);
      }
    });

    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        LocalNotification.display(event);
      }

    });

    // Work when app is in background and its still open
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data['route'];  
      _navKey.currentState?.pushNamed(routeFromMessage);
    });
  }

  Future<String?> _saveDeviceToken() async {
    String? _deviceToken = "@";
    try {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print("Could not get the token");
      print(e.toString());
    }

    if ((_deviceToken != null)) {
      print('-----------Device Token-------------' + _deviceToken);
      context.read<UserProvider>().updateDeviceToken(_deviceToken);
    }

    return _deviceToken;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return OverlaySupport.global(
          toastTheme: ToastThemeData(
              textColor: Colors.white,
              background: GlobalVariables.selectedNavBarColor),
          child: MaterialApp(
            navigatorKey: _navKey,
            builder: EasyLoading.init(),
            // scaffoldMessengerKey: _messangerKey,
            debugShowCheckedModeBanner: false,
            title: 'Amazon Clone',

            
            theme: ThemeData(
              // scaffoldBackgroundColor: GlobalVariables.backgroundColor, keytool -importkeystore -srckeystore C:\Users\OLA\upload-keystore.jks -destkeystore C:\Users\OLA\upload-keystore.jks -deststoretype pkcs12"
              colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor,
              ),
              appBarTheme: const AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              useMaterial3: true, // can remove this line
            ),
            onGenerateRoute: (settings) => generateRoute(settings),
            home:const MyHomePage()                                                
          ),
        );
      }
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
     return Builder(builder: (context) {
          if (Provider.of<UserProvider>(context).user.token.isNotEmpty) {
            return Provider.of<UserProvider>(context).user.type == 'user'
                ? const BottomBar()
                : const DashBoardScreen();
                // : const AdminScreen();
          } else {
            return const OnboardingScreen();
          }
        });
  }
}
















/**
 * 
 * 
 * 
 * POST https://fcm.googleapis.com/fcm/send
Authoritzation key="your_server_key"
// messaging.subscribeToTopic("messaging");
// messaging.unsubscribeFromTopic("messaging");

{
  "to": "/topics/messaging",
  "notification": {
    "title": "FCM",
    "body": "messaging tutorial"
  },
  "data": {
    "msgId": "msg_12342"
  }
}
 */