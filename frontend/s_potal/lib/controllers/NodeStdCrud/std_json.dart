
class Student {
  final String uid;
  final String name;
  final String email;
  final String mcid;

  Student({
    required this.uid,
    required this.name,
    required this.email,
    required this.mcid,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      mcid: json['mcid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'mcid': mcid,
    };
  }
}
