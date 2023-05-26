// ignore_for_file: avoid_print

import 'package:ecom/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ecom/utilities/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFF7B51D3),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  navigateToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, ((route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.7, 0.9],
                colors: [
                  Color.fromARGB(255, 127, 189, 237),
                  Color(0xFF4563DB),
                  Color(0xFF5036D5),
                  Color(0xFF5B16D0),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Builder(
                      builder: (context) {
                        return MaterialButton(
                          onPressed:(){
                           navigateToLogin(context);
    
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                  SizedBox(
                    height: 500.0,
                    child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SvgPicture.asset(
                                  "assets/onboard/undraw_web_shopping_re_owap.svg",
                                  height: 300.0,
                                  width: 300.0,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                'Get the Best\nasset that suit you',
                                style: kTitleStyle,
                              ),
                              const SizedBox(height: 15.0),
                              Text(
                                'Ecom is ready to serve you with virtually all goods you crave for',
                                style: kSubtitleStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: SvgPicture.asset(
                                  "assets/onboard/undraw_add_to_cart_re_wrdo.svg",
                                  height: 300.0,
                                  width: 300.0,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                'Live your life smarter\nwith us!',
                                style: kTitleStyle,
                              ),
                              const SizedBox(height: 15.0),
                              Text(
                                'Experiance a seemless procurement process with us',
                                style: kSubtitleStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                
                                child: SvgPicture.asset(
                                  "assets/onboard/undraw_stripe_payments_re_chlm.svg",
                                  height: 300.0,
                                  width: 300.0,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                'Get a new experience\nof payment',
                                style: kTitleStyle,
                              ),
                              const SizedBox(height: 15.0),
                              Text(
                                'We provide a seemless payment system for your ,',
                                style: kSubtitleStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  _currentPage != _numPages - 1
                      ? Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: MaterialButton(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Text(''),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: _currentPage == _numPages - 1
            ? Container(
                height: 100.0,
                width: double.infinity,
                color: Colors.white,
                child: Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap:(){
                       navigateToLogin(context);
    
                      },
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: Text(
                            'Get started',
                            style: TextStyle(
                              color: Color(0xFF5B16D0),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              )
            : const Text(''),
      ),
    );
  }
}
