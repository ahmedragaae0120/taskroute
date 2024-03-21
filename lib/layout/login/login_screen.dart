import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskroute/layout/app_provider.dart';
import 'package:taskroute/layout/home/home_screen.dart';
import 'package:taskroute/layout/signIn/signUp_screen.dart';
import 'package:taskroute/models/user_Model.dart';
import 'package:taskroute/shraed/FirebaseAuthErorrCodes.dart';
import 'package:taskroute/shraed/constants.dart';
import 'package:taskroute/shraed/dialog_utlis.dart';
import 'package:taskroute/shraed/providers/auth_provider.dart';
import 'package:taskroute/shraed/remote/fire_store/fire_store_helper.dart';
import 'package:taskroute/shraed/reusable_commponets/custom_text_filed.dart';

class loginScreen extends StatefulWidget {
  static const String route_name = "loginScreen";
  loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool hiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    appProvider ProviderApp = Provider.of<appProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Image.asset("assets/images/Group 6.png",
            color: Theme.of(context).colorScheme.primary),
        actions: [
          IconButton(
              onPressed: () {
                ProviderApp.changeTheme(ProviderApp.theme == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light);
              },
              icon: Icon(
                ProviderApp.theme == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              )),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * 0.07),
              Text(
                "Hi, Wecome Back! ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Hello again, you’ve been missed!",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: height * 0.04),
              Text("Email", style: Theme.of(context).textTheme.titleMedium),
              customTextfiled(
                keyboard: TextInputType.emailAddress,
                controller: emailController,
                hintText: "Please Enter Your Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "this field can't be empty";
                  }
                  if (!RegExp(constants.emailregex).hasMatch(value)) {
                    return "Enter valid Email";
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.05),
              Text("Password", style: Theme.of(context).textTheme.titleMedium),
              customTextfiled(
                keyboard: TextInputType.visiblePassword,
                controller: passwordController,
                hintText: "Please Enter Your Password",
                ObscureText: hiddenPassword,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hiddenPassword = !hiddenPassword;
                      });
                    },
                    icon: hiddenPassword
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "this field can't be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: height * 0.08),
              ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account ? ",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(signInScreen.route_name);
                      },
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.titleMedium,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    authProvider provider = Provider.of<authProvider>(context, listen: false);
    if (formkey.currentState?.validate() ?? false) {
      dialogUtils.show_loaing_dialog(context);
      try {
        UserCredential credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        userModel? user = await fireStoreHelper.getUser(credential.user!.uid);
        provider.setUser(
            newfirebaseauthUser: credential.user, newdatabaseUser: user);
        dialogUtils.hide_loaing_dialog(context);
        Navigator.pushNamedAndRemoveUntil(
            context, homeScreen.route_name, (route) => false);
      } on FirebaseAuthException catch (e) {
        dialogUtils.hide_loaing_dialog(context);
        if (e.code == FirebaseAuthErorrCodes.userNotFound) {
          print('No user found for that email.');
          dialogUtils.showMessage(
            context: context,
            message: 'No user found for that email.',
            positiveText: "Ok",
            positiveButton: () => dialogUtils.hide_loaing_dialog(context),
          );
        } else if (e.code == FirebaseAuthErorrCodes.wrongPassword) {
          print('Wrong password provided for that user.');
          dialogUtils.showMessage(
            context: context,
            message: 'Wrong password provided for that users',
            positiveText: "Ok",
            positiveButton: () => dialogUtils.hide_loaing_dialog(context),
          );
        }
      }
    }
  }
}
