import 'package:ecom/features/auth/screens/auth_screen.dart';
import 'package:ecom/features/auth/screens/register_screen.dart';
import 'package:ecom/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  // final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
    bool  isShowPassword = true;  
    bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() async{
        // updateState(true);
        EasyLoading.show(status: 'loading...', maskType: EasyLoadingMaskType.black );
        print(_emailController.text);
        print(_passwordController.text);
    await authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
    // updateState(false);
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _signInFormKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/login.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding:
                            const EdgeInsets.only(top: 50.0, bottom: 100.0),
                        child: Column(
                          children: const  [
                             Text(
                              "ECOM",
                              style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Email",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (val) {
                              if (!val!.contains("@")) {
                                return 'Enter valid email';
                              }
                              return null;
                            },
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Password",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Icon(
                            Icons.lock_open,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText:  isShowPassword ,
                            validator: (val) {
                              if (val!.length <= 5 || val.isEmpty) {
                                return 'Enter valid password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your password',
                              hintStyle: const  TextStyle(color: Colors.grey),
                              suffixIcon: InkWell(
                                onTap: () {
                                    setState(() {
                                  isShowPassword = !isShowPassword ;
                                      
                                    });
                                },
                                child:const Icon(Icons.remove_red_eye))
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            splashColor: Colors.blue.shade100,
                            color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                Transform.translate(
                                  offset: const Offset(10.0, 0.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28.0)),
                                      splashColor: Colors.white,
                                      color: Colors.white,
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                )
                              ],
                            ),
                            onPressed: _isLoading ? null : () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.center,
                            child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  const Text(
                                    "DON'T HAVE AN ACCOUNT? ",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RegisterScreen.routeName,
                                        (route) => false,
                                      );
                                    },
                                    child: const Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 139, 194, 239),
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  )
                ]),
          ),
        ),
      ),
    ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
