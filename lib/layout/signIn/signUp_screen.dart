import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskroute/layout/app_provider.dart';
import 'package:taskroute/layout/home/home_screen.dart';
import 'package:taskroute/layout/login/login_screen.dart';
import 'package:taskroute/models/user_Model.dart';
import 'package:taskroute/shraed/FirebaseAuthErorrCodes.dart';
import 'package:taskroute/shraed/constants.dart';
import 'package:taskroute/shraed/dialog_utlis.dart';
import 'package:taskroute/shraed/providers/auth_provider.dart';
import 'package:taskroute/shraed/remote/fire_store/fire_store_helper.dart';
import 'package:taskroute/shraed/reusable_commponets/custom_text_filed.dart';

class signInScreen extends StatefulWidget {
  static const String route_name = "signInScreen";
  signInScreen({super.key});

  @override
  State<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
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
                "Create an account",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Connect with your friends today!",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: height * 0.04),
              Text("Name", style: Theme.of(context).textTheme.titleMedium),
              customTextfiled(
                keyboard: TextInputType.emailAddress,
                controller: nameController,
                hintText: "Please Enter Your Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "this field can't be empty";
                  }
                  if (value.length > 25) {
                    return "sorry is length 25 char";
                  }
                  return null;
                },
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
                    singUp();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
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

  void singUp() async {
    authProvider provider = Provider.of<authProvider>(context, listen: false);
    if (formkey.currentState?.validate() ?? false) {
      try {
        dialogUtils.show_loaing_dialog(context);
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        fireStoreHelper.addUser(
            userId: credential.user!.uid,
            email: emailController.text,
            name: nameController.text);
        dialogUtils.hide_loaing_dialog(context);
        dialogUtils.showMessage(
          context: context,
          message: "Register successed id: ${credential.user?.uid}",
          positiveText: "ok",
          positiveButton: () {
            provider.setUser(
                newfirebaseauthUser: credential.user,
                newdatabaseUser: userModel(
                    name: nameController.text,
                    email: emailController.text,
                    id: credential.user!.uid));
            provider.retriveDatabaseUserData();
            dialogUtils.hide_loaing_dialog(context);
            Navigator.pushNamedAndRemoveUntil(
                context, homeScreen.route_name, (route) => false);
          },
        );
      } on FirebaseAuthException catch (e) {
        dialogUtils.hide_loaing_dialog(context);
        if (e.code == FirebaseAuthErorrCodes.weakPassword) {
          print('The password provided is too weak.');
          dialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak.',
            positiveText: "Ok",
            positiveButton: () => dialogUtils.hide_loaing_dialog(context),
          );
        } else if (e.code == FirebaseAuthErorrCodes.emailAlreadyInuse) {
          print('The account already exists for that email.');
          dialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email go to login',
            positiveText: "Ok",
            positiveButton: () {
              dialogUtils.hide_loaing_dialog(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, loginScreen.route_name, (route) => false);
            },
          );
        }
      } catch (e) {
        dialogUtils.hide_loaing_dialog(context);
        print(e);
        dialogUtils.showMessage(
          context: context,
          message: e.toString(),
          positiveText: "ok",
          positiveButton: () => dialogUtils.hide_loaing_dialog(context),
        );
      }
      await provider.retriveDatabaseUserData();
    }
  }
}
