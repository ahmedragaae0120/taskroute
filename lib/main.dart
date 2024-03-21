import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskroute/firebase_options.dart';
import 'package:taskroute/layout/app_provider.dart';
import 'package:taskroute/layout/home/home_screen.dart';
import 'package:taskroute/layout/login/login_screen.dart';
import 'package:taskroute/layout/signIn/signUp_screen.dart';
import 'package:taskroute/shraed/providers/auth_provider.dart';
import 'package:taskroute/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => authProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => appProvider()..initialize(),
      )
    ],
    child: const task_route(),
  ));
}

class task_route extends StatelessWidget {
  const task_route({super.key});

  @override
  Widget build(BuildContext context) {
    authProvider provider = Provider.of<authProvider>(context);
    appProvider ProviderApp = Provider.of<appProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      themeMode: ProviderApp.theme,
      routes: {
        loginScreen.route_name: (context) => loginScreen(),
        signInScreen.route_name: (context) => signInScreen(),
        homeScreen.route_name: (context) => homeScreen(),
      },
      initialRoute: provider.isfirebaseAuthUser()
          ? homeScreen.route_name
          : loginScreen.route_name,
    );
  }
}
