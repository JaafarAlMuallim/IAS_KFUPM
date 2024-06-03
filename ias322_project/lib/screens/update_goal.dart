import 'package:flutter/material.dart';
import 'package:ias322_project/models/goal.dart';

class UpdateGoal extends StatefulWidget {
  const UpdateGoal({super.key, required this.goalItem});
  final GoalItem goalItem;

  @override
  State<UpdateGoal> createState() {
    return _UpdateGoalState();
  }
}

class _UpdateGoalState extends State<UpdateGoal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _targetContoller = TextEditingController();
  final TextEditingController _doneController = TextEditingController();

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
        Navigator.of(context).pop(
        GoalItem(
          goalId: widget.goalItem.goalId,
          title: _nameController.text,
          target: int.parse(_targetContoller.text),
          done: int.parse(_doneController.text),
        ),
      );
    }
  }

  @override
  void initState() {
    _nameController.text = widget.goalItem.title;
    _targetContoller.text = widget.goalItem.target.toString();
    _doneController.text = widget.goalItem.done.toString();
    super.initState();
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
                TextFormField(
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
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('المنجز'),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _doneController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.tryParse(value)! <= 0 ||
                        int.tryParse(value)! >
                            int.tryParse(_targetContoller.text)!) {
                      return 'يجب إدخال عدد أيام صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(width: 8),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _saveItem,
                      child: const Text('تأكيد'),
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
