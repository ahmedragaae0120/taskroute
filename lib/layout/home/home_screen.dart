import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskroute/layout/app_provider.dart';
import 'package:taskroute/layout/home/widgets/Featured_course_widget.dart';
import 'package:taskroute/layout/home/widgets/best_seling_builder.dart';
import 'package:taskroute/layout/home/widgets/best_selling_widget.dart';
import 'package:taskroute/layout/home/widgets/featuredC_builder.dart';
import 'package:taskroute/layout/login/login_screen.dart';
import 'package:taskroute/models/courses_model.dart';
import 'package:taskroute/models/user_Model.dart';
import 'package:taskroute/shraed/dialog_utlis.dart';
import 'package:taskroute/shraed/providers/auth_provider.dart';
import 'package:taskroute/shraed/remote/fire_store/fire_store_helper.dart';

class homeScreen extends StatefulWidget {
  static const String route_name = "homeScreen";
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    authProvider provider = Provider.of<authProvider>(context);
    appProvider ProviderApp = Provider.of<appProvider>(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset("assets/images/Group 6.png",
              color: Theme.of(context).colorScheme.primary),
          title: Column(
            children: [
              Text(
                "Welocme to ${provider.databaseUser?.name}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                "Enjoy our courses",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          ),
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
            SizedBox(width: 10),
            IconButton(
                onPressed: () {
                  provider.logOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, loginScreen.route_name, (route) => false);
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Featured ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Courses",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  featuredCBuilder(),
                  SliverToBoxAdapter(child: SizedBox(height: height * 0.05)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Best Selling ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Courses",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 20),
                          ),
                          Spacer(),
                          Text(
                            "View All",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 15)),
                  bestSellingBuilder(),
                ],
              ),
            )
          ],
        ));
  }
}
