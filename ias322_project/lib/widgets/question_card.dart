import 'package:flutter/material.dart';
import 'package:ias322_project/models/qs.dart';
import 'package:ias322_project/screens/question_answer_screen.dart';

class QuestionCard extends StatelessWidget {
  final QuestionDB question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    QuestionAnswerScreen(question: question))),
        child: Card(
          color: ThemeData.light().colorScheme.inversePrimary,
          child: Center(
            child: ListTile(
              leading: Image.asset(question.photo, width: 50, height: 50),
              title: Row(
                children: [
                  Text(
                    question.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              subtitle: Text(
                question.question,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
