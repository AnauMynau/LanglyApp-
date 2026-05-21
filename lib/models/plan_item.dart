class PlanItem {
  final String id;
  final String name;
  final String duration;
  final int intensity;
  final DateTime date;
  final String studentName;
  final bool isSelfStudy;

  PlanItem({
    required this.id,
    required this.name,
    required this.duration,
    required this.intensity,
    required this.date,
    this.studentName = '',
    this.isSelfStudy = true,
  });

  PlanItem copyWith({String? studentName, bool? isSelfStudy}) {
    return PlanItem(
      id: id,
      name: name,
      duration: duration,
      intensity: intensity,
      date: date,
      studentName: studentName ?? this.studentName,
      isSelfStudy: isSelfStudy ?? this.isSelfStudy,
    );
  }
}