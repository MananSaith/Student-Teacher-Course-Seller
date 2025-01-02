class Average {
  final String courseId;
  final double value;
  final DateTime date;

  Average({
    required this.courseId,
    required this.value,
    required this.date,
  });

  // Factory method to create an Average object from JSON
  factory Average.fromJson(Map<String, dynamic> json) {
    return Average(
      courseId: json['courseId'],
      value: (json['value'] as num).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  // Method to convert an Average object to JSON
  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'value': value,
      'date': date.toIso8601String(),
    };
  }
}
