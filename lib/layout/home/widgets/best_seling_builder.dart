import 'package:flutter/material.dart';
import 'package:taskroute/layout/home/widgets/best_selling_widget.dart';
import 'package:taskroute/models/courses_model.dart';
import 'package:taskroute/shraed/remote/fire_store/fire_store_helper.dart';

class bestSellingBuilder extends StatelessWidget {
  const bestSellingBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: fireStoreHelper.getBestSellingCourse(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator.adaptive()));
        }
        if (snapshot.hasError) {
          return Text("Someting went wrong ${snapshot.error} ");
        }
        List<courseModel> bestSellingCourses = snapshot.data ?? [];
        return SliverList.separated(
            itemBuilder: (context, index) =>
                bestSellingWidget(course: bestSellingCourses[index]),
            separatorBuilder: (context, index) => SizedBox(
                  height: height * 0.02,
                ),
            itemCount: bestSellingCourses.length);
      },
    );
  }
}
