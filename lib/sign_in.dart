import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop_app/home_page.dart';
import 'package:shop_app/lang_dialog.dart';
import 'package:shop_app/sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> SignInFormKey = GlobalKey<FormState>();

  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();

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

                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: EmailController.text,
                            password: PasswordController.text,
                          );
                          if (credential == null) {
                            print("credential is null");
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Check your input errors and try again")),
                            );
                          }
                        }

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
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Durations.extralong2,
                          child: const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      context.tr("sign_up"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
