class CourceEnrolled {
  final String uid;
  final String objectId;

  CourceEnrolled({required this.uid, required this.objectId});

  // Convert JSON to model
  factory CourceEnrolled.fromJson(Map<String, dynamic> json) {
    return CourceEnrolled(
      uid: json['uid'],
      objectId: json['objectId'],
    );
  }

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'objectId': objectId,
    };
  }
}
