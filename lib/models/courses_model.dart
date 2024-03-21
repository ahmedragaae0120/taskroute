import 'dart:math';

class courseModel {
  String? image;
  String? title;
  int? studentNum;
  String? courseId;
  courseModel(
      {required this.image, required this.title, required this.studentNum,this.courseId});

  courseModel.FromFirestore(Map<String, dynamic> data) {
    image = data["image"];
    title = data["title"];
    studentNum = data["studentNum"];
    courseId = data["courseId"];
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (image != null) "image": image,
      if (title != null) "title": title,
      if (studentNum != null) "studentNum": studentNum,
      if (courseId != null) "courseId": courseId,
    };
  }

  static List<courseModel> courses = [
    courseModel(
      image: 'https://i.ytimg.com/vi/LFDKlkQpPSA/maxresdefault.jpg',
      title: 'مقدمة إلى لغة Dart',
      studentNum: Random().nextInt(100) + 10,
    ),
    courseModel(
      image:
          'https://khamsat.hsoubcdn.com/images/services/1744569/5bc5c047233901c14b1cf0bb31c73b8b.jpg',
      title: 'برمجة Flutter لتصميم تطبيقات الجوال',
      studentNum: Random().nextInt(100) + 10,
    ),
    courseModel(
      image:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiEyfuH0qrE6WxHk3xIlex2QI9WVQ5wRJkgm5_yUjm_L-vRy0b6mFTU-3Z6bHzAf_BlK5P9MzkK-dgucGFvPQw-Ez24FGncuZ4wF-WC_P1WaaTdL2a7BkIZFzUg5dLbYF0PhtwAJoLbg7-VZ_-G_ZG500dkRLN3MA2at_EmNUDY7KQic-ghN_yoEMoi/s1280/%D9%A2%D9%A0%D9%A2%D9%A2%D9%A0%D9%A4%D9%A1%D9%A3_%D9%A2%D9%A3%D9%A5%D9%A8%D9%A1%D9%A3.jpg',
      title: 'تعلم لغة Python من الصفر',
      studentNum: Random().nextInt(100) + 10,
    ),
    courseModel(
      image:
          'https://academy.hsoub.com/uploads/monthly_2023_01/374072051_--.jpg.c7dab48ef8c4be326eb8c9f64a2c0b3c.jpg',
      title: 'أساسيات الذكاء الاصطناعي',
      studentNum: Random().nextInt(100) + 10,
    ),
    courseModel(
      image:
          'https://khamsat.hsoubcdn.com/images/services/1949477/5e5542b727c6cc2de3f34cb23624a4c4.jpg',
      title: 'تصميم المواقع الإلكترونية باستخدام HTML و CSS',
      studentNum: Random().nextInt(100) + 10,
    ),
    courseModel(
      image:
          'https://th.bing.com/th/id/OIP.MwhIhu0kcG-Q1NSIEP6puwHaFK?rs=1&pid=ImgDetMain',
      title: 'التسويق الرقمي وريادة الأعمال',
      studentNum: Random().nextInt(100) + 10,
    ),
    courseModel(
      image:
          'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhk5IT0AJFPkxIHeHFnvk_47n8Teye0Va9tj55d1QulD_xnZ7WDu_sZ8p35e6A-im3aEOYnLVKJAKgvKmIfKuRYI3S_4KgF1mjKfHEFB7KHyCf4gsrZL4RatBoKntrINGatcJKMcPrS8NycSTIkchWXJTA5yF2hmkZHERTPlzWrYIv2k9jW4TTZzLRA/s1320/beginner-photographers.jpg',
      title: 'التصوير الفوتوغرافي الاحترافي',
      studentNum: Random().nextInt(100) + 10,
    ),
    courseModel(
      image:
          'https://th.bing.com/th/id/OIP.xK6jnviQEel91W4KwdBiqQAAAA?w=300&h=300&rs=1&pid=ImgDetMain',
      title: 'اللغة العربية: كتابة وتحدث',
      studentNum: Random().nextInt(100) + 10,
    ),
    courseModel(
      image:
          'https://th.bing.com/th/id/R.af28455e34eede7f96ab9fec2332ef95?rik=kaArIbMRG5YLUw&pid=ImgRaw&r=0',
      title: 'التحليل المالي وإدارة الأعمال',
      studentNum: Random().nextInt(100) + 10,
    ),
    courseModel(
      image:
          'https://www.e3melbusiness.net/assets/images/%D8%AA%D8%B9%D9%84%D9%85-%D9%85%D9%87%D8%A7%D8%B1%D8%A7%D8%AA-%D9%81%D9%86-%D8%A7%D9%84%D8%A7%D9%84%D9%82%D8%A7%D8%A1-%D8%A7%D9%85%D8%A7%D9%85-%D8%A7%D9%84%D8%AC%D9%85%D9%87%D9%88%D8%B1.jpg',
      title: 'مهارات التواصل والتحدث أمام الجمهور',
      studentNum: Random().nextInt(100) + 10,
    ),
  ];
}
