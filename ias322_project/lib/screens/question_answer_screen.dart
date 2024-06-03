import 'package:flutter/material.dart';
import 'package:ias322_project/models/answer.dart';
import 'package:ias322_project/models/qs.dart';
import 'package:ias322_project/network/api_client.dart';
import 'package:ias322_project/widgets/answer_card.dart';
import 'package:ias322_project/widgets/question_info_card.dart';

class QuestionAnswerScreen extends StatefulWidget {
  const QuestionAnswerScreen({super.key, required this.question});
  final QuestionDB question;

  @override
  State<QuestionAnswerScreen> createState() => _QuestionAnswerScreenState();
}

class _QuestionAnswerScreenState extends State<QuestionAnswerScreen> {
  final List<Answer> _answers = [];
  bool _loading = false;

  getAnswers() async {
    ApiClient apiClient = ApiClient();
    setState(() {
      _loading = true;
    });
    final foundAnswers =
        await apiClient.getAnswers(widget.question.questionId!);
    if (foundAnswers != null) {
      setState(() {
        foundAnswers.forEach((element) {
          _answers.add(Answer.fromJson(element));
        });
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getAnswers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().colorScheme.background,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: ThemeData.light().colorScheme.primaryContainer,
        elevation: 4.0,
        title: Text(
          widget.question.title,
          style: TextStyle(
            color: ThemeData.light().colorScheme.onBackground,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    QuestionInfoCard(question: widget.question),
                    SizedBox(
                      height: 700,
                      child: _answers.isEmpty
                          ? const Center(
                              child: Text(
                                "لا توجد إجابات على هذا السؤال، كن أول من يجيب!",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : ListView(
                              children: _answers
                                  .map((ans) => AnswerCard(ans: ans))
                                  .toList(),
                            ),
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeData.light().colorScheme.primary,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                TextEditingController answerController =
                    TextEditingController();
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    height: 500,
                    color: ThemeData.light().colorScheme.background,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text('أضف إجابتك',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: answerController,
                            decoration: InputDecoration(
                              hintText: 'إجابتك',
                              hintStyle: TextStyle(
                                  color: ThemeData.light()
                                      .colorScheme
                                      .onBackground),
                              fillColor: ThemeData.light()
                                  .colorScheme
                                  .primaryContainer,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                ThemeData.light().colorScheme.primary,
                            shadowColor: Colors.greenAccent,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            minimumSize: const Size(200, 40),
                          ),
                          onPressed: () async {
                            ApiClient apiClient = ApiClient();
                            final data = await apiClient.addAnswer(
                                answerController.text,
                                widget.question.questionId!);
                            setState(() {
                              _answers.add(Answer.fromJson(data));
                            });
                            if (context.mounted) Navigator.of(context).pop();
                          },
                          child: Text(
                            'أضف إجابتك',
                            style: TextStyle(
                                fontSize: 20,
                                color: ThemeData.light().colorScheme.onPrimary),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add, color: ThemeData.light().colorScheme.onPrimary),
      ),
    );
  }
}
