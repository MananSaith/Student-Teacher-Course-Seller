class Course {
  String? id;
  String title;
  String image;
  String category;
  String description;
  double price;
  List<String> videoLectures;
  List<String> files;
  String uid;
  String? mcid;

  Course({
    this.id,
    required this.title,
    required this.image,
    required this.category,
    required this.description,
    required this.price,
    required this.videoLectures,
    required this.files,
    required this.uid,
    this.mcid,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      category:json["category"],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      videoLectures: List<String>.from(json['videoLectures']),
      files: List<String>.from(json['files']),
      uid: json['uid'],
      mcid: json['mcid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      "category":category,
      'description': description,
      'price': price,
      'videoLectures': videoLectures,
      'files': files,
      'uid': uid,
      if (mcid != null) 'mcid': mcid,
    };
  }
}
