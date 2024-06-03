import 'package:flutter/material.dart';
import 'package:ias322_project/models/qs.dart';
import 'package:ias322_project/network/api_client.dart';
import 'package:ias322_project/widgets/bottom_navbar.dart';
import 'package:ias322_project/widgets/question_card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<QuestionDB> questions = [];
  bool _loading = false;

  getQuestions() async {
    ApiClient apiClient = ApiClient();
    setState(() {
      _loading = true;
    });
    final foundQuestions = await apiClient.getQuestions();
    if (foundQuestions != null) {
      setState(() {
        foundQuestions.forEach((element) {
          questions.add(QuestionDB.fromJson(element));
        });
      });
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getQuestions();
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
        title: Center(
          child: Text(
            'أسئلة المجتمع',
            style: TextStyle(
              color: ThemeData.light().colorScheme.onBackground,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: questions.isEmpty
                    ? Center(
                        child: Text(
                          "لا توجد أسئلة حتى الآن، كن أول من ينشر!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ThemeData.light().colorScheme.onBackground,
                              fontSize: 20),
                        ),
                      )
                    : Column(
                        children: questions
                            .map((question) => QuestionCard(question: question))
                            .toList()),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeData.light().colorScheme.primary,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                TextEditingController titleController = TextEditingController();
                TextEditingController questionController =
                    TextEditingController();
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    height: 500,
                    color: ThemeData.light().colorScheme.background,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text('أضف سؤالك',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'العنوان',
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
                            controller: titleController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: questionController,
                            decoration: InputDecoration(
                              hintText: 'السؤال',
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
                            final data = await apiClient.createQuestion(
                                titleController.text, questionController.text);
                            setState(() {
                              questions.add(QuestionDB.fromJson(data));
                            });
                            if (context.mounted) Navigator.pop(context);
                          },
                          child: Text(
                            'أضف',
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
