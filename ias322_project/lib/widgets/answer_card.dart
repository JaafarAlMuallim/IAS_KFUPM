import 'package:flutter/material.dart';
import 'package:ias322_project/models/answer.dart';

class AnswerCard extends StatelessWidget {
  final Answer ans;

  const AnswerCard({super.key, required this.ans});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        child: Card(
          color: ThemeData.light().colorScheme.primaryContainer,
          child: Center(
            child: ListTile(
              leading: Image.asset("assets/default.png", width: 50, height: 50),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ans.answer,
                    style: TextStyle(
                        fontSize: 14,
                        color:
                            ThemeData.light().colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المشاهدات: 75',
                        style: TextStyle(
                            fontSize: 14,
                            color: ThemeData.light()
                                .colorScheme
                                .onPrimaryContainer),
                      ),
                      Text(
                        'التاريخ: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        style: TextStyle(
                            fontSize: 14,
                            color: ThemeData.light()
                                .colorScheme
                                .onPrimaryContainer),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
