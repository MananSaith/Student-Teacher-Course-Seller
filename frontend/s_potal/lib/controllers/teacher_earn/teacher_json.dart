class TeacherJson {
  int earn;
  String? id; // renamed from _id to id to follow Dart naming conventions
  String name;
  String email;
  String uid;
  String mcid;
  bool verify;

  TeacherJson({
    required this.earn,
    this.id,
    required this.name,
    required this.email,
    required this.uid,
    required this.mcid,
    required this.verify,
  });

  // factory TeacherJson.fromJson(Map<String, dynamic> json) {
  //   print("0000000000000000000000000 $json");

  //   return TeacherJson(
  //     earn: json['earn'],
  //     id: json['_id'], // mapping to the renamed field
  //     name: json['name'],
  //     email: json['email'],
  //     uid: json['uid'],
  //     mcid: json['mcid'],
  //     verify: json['verify'],
  //   );
  // }
  factory TeacherJson.fromJson(Map<String, dynamic> json) {
    return TeacherJson(
      earn: json['earn'] != null
          ? int.parse(json['earn'].toString())
          : 0, // Default to 0 if null
      id: json['_id']?.toString() ?? '', // Default to an empty string if null
      name:
          json['name']?.toString() ?? 'Unknown', // Default to 'Unknown' if null
      email: json['email']?.toString() ?? '',
      uid: json['uid']?.toString() ?? '',
      mcid: json['mcid']?.toString() ?? '',
      verify: json['verify'] ?? false, // Default to false if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'earn': earn,
      'name': name,
      'email': email,
      'uid': uid,
      'mcid': mcid,
      'verify': verify,
    };
  }
}
