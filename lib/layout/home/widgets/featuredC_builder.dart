import 'package:flutter/material.dart';
import 'package:taskroute/layout/home/widgets/Featured_course_widget.dart';
import 'package:taskroute/models/courses_model.dart';
import 'package:taskroute/shraed/remote/fire_store/fire_store_helper.dart';

class featuredCBuilder extends StatelessWidget {
  const featuredCBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: fireStoreHelper.getAllCourse(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator.adaptive()));
        }
        if (snapshot.hasError) {
          return Text("Someting went wrong ${snapshot.error} ");
        }
        List<courseModel> courses = snapshot.data ?? [];
        return SliverToBoxAdapter(
          child: SizedBox(
            height: height * 0.3,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  FeaturedCourseWidget(course: courses[index]),
              itemCount: courses.length,
            ),
          ),
        );
      },
    );
  }
}
