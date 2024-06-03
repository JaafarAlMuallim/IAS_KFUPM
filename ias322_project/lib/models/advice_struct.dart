import 'package:flutter/material.dart';

class Advice {
  final String paragraph;
  final String title;
  final IconData icon;

  Advice({required this.paragraph, required this.title, required this.icon});
}

class Advices {
  static List<Advice> advices = [
    Advice(
        title: "التنظيم الجيد للوقت",
        paragraph:
            "لكي تحقق النجاح في دراستك، من الضروري أن تنظم وقتك بفعالية. حاول إنشاء جدول زمني يومي يشمل أوقات محددة للدراسة، الراحة، والأنشطة الأخرى.",
        icon: Icons.access_alarm),
    Advice(
        title: "تحديد الأهداف والإنجازات",
        paragraph:
            "وضع أهداف قصيرة وطويلة الأمد يمكن أن يساعدك في الحفاظ على الدافع والتركيز. تأكد من أن أهدافك واقعية وقابلة للقياس وراجعها بانتظام.",
        icon: Icons.bar_chart),
    Advice(
        title: "تقوية المهارات الدراسية",
        paragraph:
            "تطوير مهاراتك الدراسية، مثل التلخيص، التنظيم، وتقنيات الحفظ، يمكن أن يحسن من أدائك الأكاديمي بشكل كبير. استفد من الورش والدورات التدريبية لتحسين هذه المهارات.",
        icon: Icons.school),
    Advice(
        title: "الصحة النفسية والجسدية",
        paragraph:
            "الحفاظ على صحتك النفسية والجسدية أساسي للنجاح في الدراسة. تأكد من الحصول على قسط كاف من النوم، تناول طعام صحي، وممارسة الرياضة بانتظام.",
        icon: Icons.health_and_safety),
    Advice(
        title: "التواصل مع المعلمين",
        paragraph:
            "لا تخف من طلب المساعدة من معلميك. التواصل الجيد مع المعلمين يمكن أن يوفر لك الدعم والتوجيه اللازمين لتحسين مستواك الدراسي.",
        icon: Icons.email),
    Advice(
        title: "استخدام التكنولوجيا بفعالية",
        paragraph:
            "تستطيع التكنولوجيا أن تكون أداة فعالة للدراسة إذا تم استخدامها بشكل صحيح. استفد من التطبيقات التعليمية والمنصات الإلكترونية لتعزيز تعلمك.",
        icon: Icons.devices)
  ];
}
