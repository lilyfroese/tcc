class Meta {
  final int id;
  final String title;
  final String? description;
  final String type;
  final int? hydrationGoalMl;
  final int? hydrationCupsGoal;
  final int? sleepGoalHours;
  final String? sleepTime;
  final String? wakeTime;
  final String? color;
  final String? icon;
  final String? frequency;
  final bool isActive;

  Meta({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    this.hydrationGoalMl,
    this.hydrationCupsGoal,
    this.sleepGoalHours,
    this.sleepTime,
    this.wakeTime,
    this.color,
    this.icon,
    this.frequency,
    required this.isActive,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      hydrationGoalMl: json['hydrationGoalMl'],
      hydrationCupsGoal: json['hydrationCupsGoal'],
      sleepGoalHours: json['sleepGoalHours'],
      sleepTime: json['sleepTime'],
      wakeTime: json['wakeTime'],
      color: json['color'],
      icon: json['icon'],
      frequency: json['frequency'],
      isActive: json['isActive'] ?? true,
    );
  }
}
