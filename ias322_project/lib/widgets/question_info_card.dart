import 'package:flutter/material.dart';
import 'package:ias322_project/models/qs.dart';

class QuestionInfoCard extends StatelessWidget {
  final QuestionDB question;

  const QuestionInfoCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ThemeData.light().colorScheme.inversePrimary,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          leading: Image.asset(question.photo, width: 50, height: 50),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.right,
                question.question,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الإجابات: 4',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const Text(
                    'المشاهدات: 120',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  Text(
                      'التاريخ: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      style: const TextStyle(fontSize: 14, color: Colors.black))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
