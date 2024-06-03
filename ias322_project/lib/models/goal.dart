class GoalItem {
  String? goalId;
  String title;
  int target;
  int done;

  GoalItem({
    this.goalId,
    required this.title,
    required this.target,
    this.done = 0,
  });

  double get progress {
    return done / target;
  }

  factory GoalItem.fromJson(Map<String, dynamic> json) {
    return GoalItem(
      goalId: json['goal_id'],
      title: json['title'],
      target: json['target'],
      done: json['done'],
    );
  }
}
