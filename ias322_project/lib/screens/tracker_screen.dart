import 'package:flutter/material.dart';
import 'package:ias322_project/models/goal.dart';
import 'package:ias322_project/network/api_client.dart';
import 'package:ias322_project/screens/new_goal.dart';
import 'package:ias322_project/screens/update_goal.dart';
import 'package:ias322_project/widgets/bottom_navbar.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  final List<GoalItem> _goalItems = [];
  bool _loading = false;
  ApiClient apiClient = ApiClient();

  getGoals() async {
    setState(() {
      _loading = true;
    });
    final goals = await apiClient.getGoals();
    setState(() {
      _goalItems.clear();
      if (goals != null) {
        goals.forEach((element) {
          _goalItems.add(GoalItem.fromJson(element));
        });
      }
    });
    setState(() {
      _loading = false;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GoalItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewGoal(),
      ),
    );
    if (newItem == null) {
      return;
    }
    final addedGoal = await apiClient.createGoal(newItem.title, newItem.target);
    setState(() {
      _goalItems.add(GoalItem.fromJson(addedGoal));
    });
  }

  void _updateItem(GoalItem item) async {
    final updatedItem = await Navigator.of(context).push<GoalItem>(
      MaterialPageRoute(
        builder: (ctx) => UpdateGoal(
          goalItem: item,
        ),
      ),
    );
    if (updatedItem == null) {
      return;
    }
    final updatedGoal = await apiClient.updateGoal(
      updatedItem.title,
      updatedItem.target,
      updatedItem.done,
      item.goalId!,
    );
    setState(() {
      final oldIndex = _goalItems.indexOf(item);
      _goalItems.removeAt(oldIndex);
      _goalItems.insert(oldIndex, GoalItem.fromJson(updatedGoal));
    });
  }

  void _removeItem(GoalItem item) {
    setState(() {
      _goalItems.remove(item);
    });
    apiClient.deleteGoal(item.goalId!);
  }

  _updateItemOne(
    GoalItem item,
  ) async {
    final updatedGoal = await apiClient.updateGoal(
      item.title,
      item.target,
      item.done + 1,
      item.goalId!,
    );
    setState(() {
      final oldIndex = _goalItems.indexOf(item);
      _goalItems.removeAt(oldIndex);
      _goalItems.insert(oldIndex, GoalItem.fromJson(updatedGoal));
    });
  }

  @override
  void initState() {
    getGoals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
        child: Text(
      'لا توجد لديك أهداف حتى الآن، قم بإضافة أهدافك الجديدة.',
      style: TextStyle(fontSize: 18),
    ));

    if (_goalItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _goalItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_goalItems[index]);
          },
          key: ValueKey(_goalItems[index].goalId),
          child: ListTile(
              onTap: () => {
                    _updateItem(_goalItems[index]),
                  },
              title: Column(
                children: [
                  Text(_goalItems[index].title),
                  Center(
                    child: Text(
                        "${((_goalItems[index].done / _goalItems[index].target) * 100).toStringAsFixed(2)}%"),
                  ),
                  LinearProgressIndicator(
                    value: _goalItems[index].done / _goalItems[index].target,
                  )
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _updateItemOne(_goalItems[index]);
                },
              )),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ThemeData.light().colorScheme.background,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        shadowColor: ThemeData.light().shadowColor,
        backgroundColor: ThemeData.light().colorScheme.primaryContainer,
        elevation: 4.0,
        title: Center(
          child: Text(
            'أهدافك',
            style: TextStyle(
              color: ThemeData.light().colorScheme.onBackground,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : content,
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ThemeData.light().colorScheme.primary,
        onPressed: _addItem,
        child: Icon(Icons.add, color: ThemeData.light().colorScheme.onPrimary),
      ),
    );
  }
}
