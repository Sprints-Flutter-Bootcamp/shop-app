import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/home_page.dart';
import 'package:shop_app/lang_dialog.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> SignInFormKey = GlobalKey<FormState>();

  TextEditingController FullNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController CheckPasswordController = TextEditingController();

  bool hidePassword = true;
  void switchVisibility() {
    hidePassword = !hidePassword;
  }

  void successDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign in successful!"),
          content: const Text(
              "Welcome to Xiaomi Shopping App! Click OK to continue"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: Durations.extralong2,
                    child: MyHomePage(),
                  ),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
          title: Text(context.tr("Xiaomi_Shopping_App")),
          actions: [
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                langDialog(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: SignInFormKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Image.asset(""),
                  Icon(Icons.shopify_sharp, size: 100),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: FullNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: context.tr("full_name"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      // check if the first letter is uppercase or not
                      else if (value[0] != value[0].toUpperCase()) {
                        return 'Please make sure the first letter is capitalized';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: EmailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: context.tr("email"),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: PasswordController,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: context.tr("password"),
                        suffixIcon: IconButton(
                          onPressed: () {
                            switchVisibility();
                            setState(() {});
                          },
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: CheckPasswordController,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock_outlined),
                        border: OutlineInputBorder(),
                        labelText: context.tr("confirm_password"),
                        suffixIcon: IconButton(
                          onPressed: () {
                            switchVisibility();
                            setState(() {});
                          },
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value != PasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (SignInFormKey.currentState!.validate()) {
                          successDialog();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Check your input errors and try again")),
                          );
                        }
                      },
                      child: Text(context.tr("sign_in"))),
                ],
              ),
            ),
          ),
        ));
  }
}
