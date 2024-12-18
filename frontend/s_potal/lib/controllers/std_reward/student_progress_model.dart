class StudentProgress {
  final String? id;
  final String uid;
  final String courseName;
  final int percentage;

  StudentProgress({
     this.id,
    required this.uid,
    required this.courseName,
    required this.percentage,
  });

  // Factory method to create an instance from JSON
  factory StudentProgress.fromJson(Map<String, dynamic> json) {
    return StudentProgress(
      id: json['_id'],
      uid: json['uid'],
      courseName: json['courcename'],
      percentage: json['percentage'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'courcename': courseName,
      'percentage': percentage,
    };
  }
}
