import 'package:flutter/material.dart';
import 'package:taskroute/models/courses_model.dart';

class bestSellingWidget extends StatelessWidget {
  courseModel course;
  bestSellingWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: hight * 0.12,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.fill,
                    image: NetworkImage(course.image ?? ""),
                  ),
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''${course.title}''' ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  '''${course.studentNum} Students Enrolled''',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: Text(
                  "join Now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
