import 'package:flutter/material.dart';

class FeaturedCourseWidget extends StatelessWidget {
  const FeaturedCourseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        image: DecorationImage(image: AssetImage("assets/images/route 1.png")),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            "",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
