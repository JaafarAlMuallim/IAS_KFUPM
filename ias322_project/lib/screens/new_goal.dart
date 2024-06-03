import 'package:flutter/material.dart';
import 'package:ias322_project/models/goal.dart';

class NewGoal extends StatefulWidget {
  const NewGoal({super.key});

  @override
  State<NewGoal> createState() {
    return _NewGoalState();
  }
}

class _NewGoalState extends State<NewGoal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _targetContoller = TextEditingController();

  void _saveItem() {
    Navigator.of(context).pop(
      GoalItem(
        title: _nameController.text,
        target: int.parse(_targetContoller.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أضف هدف جديد'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('الهدف'),
                  ),
                  controller: _nameController,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('المدة (أيام)'),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _targetContoller,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'يجب إدخال عدد أيام صحيح';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('إعادة تعيين الحقول'),
                    ),
                    ElevatedButton(
                      onPressed: _saveItem,
                      child: const Text('إضافة الهدف'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
