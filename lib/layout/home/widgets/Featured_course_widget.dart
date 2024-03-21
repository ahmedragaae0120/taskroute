import 'package:flutter/material.dart';
import 'package:taskroute/models/courses_model.dart';

class FeaturedCourseWidget extends StatelessWidget {
  courseModel course;
  FeaturedCourseWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: hight * 0.3,
      width: width * 0.5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(course.image ?? ""),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Text(
              course.title ?? "",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Text(
              "${course.studentNum} Students Enrolled",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: hight * 0.01),
          Center(
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: Text(
                  "Enroll Now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )),
          ),
          SizedBox(height: hight * 0.01),
        ],
      ),
    );
  }
}
