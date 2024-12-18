// item_model.dart
class TeacherJson {
  final String name;
  final String email;
  final String uid;
  final String mcid;
  final bool verify;

  TeacherJson({
    required this.name,
    required this.email,
    required this.uid,
    required this.mcid,
    required this.verify,
  });



// ya tab call ho ga jab hum gata get kara ga 
  factory TeacherJson.fromJson(Map<String, dynamic> json) {
    return TeacherJson(
      name: json['name'],
      email: json['email'],
       uid: json['uid'] ?? '',
      mcid: json['mcid'],
      verify: json['verify'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      "email":email,
      "uid":uid,
      "mcid":mcid,
      "verify":verify
    };
  }
}
