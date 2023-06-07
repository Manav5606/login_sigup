class TrusterUser {
  String uid;
  String username;
  String email;
  String fcmToken;
  String fullName;
  String mobile;
  String countryCode;
  String imageUrl;
  String ssnNumber;
  DateTime dob;
  String dlImageUrl;
  bool phoneVerified;
  bool ssnVerified;
  String rapydId;

  TrusterUser(
      {required this.uid,
      required this.username,
      required this.email,
      required this.fcmToken,
      required this.fullName,
      required this.mobile,
      required this.countryCode,
      required this.imageUrl,
      required this.ssnNumber,
      required this.dob,
      required this.dlImageUrl,
      required this.phoneVerified,
      required this.ssnVerified,
      this.rapydId = ''});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      'uid': uid,
      'username': username,
      'email': email,
      'fcmToken': fcmToken,
      'fullName': fullName,
      'mobile': mobile,
      'countryCode': countryCode,
      'imageUrl': imageUrl,
      'ssnNumber': ssnNumber,
      'dob': dob.toString(),
      'dlImageUrl': dlImageUrl,
      'phoneVerified': phoneVerified,
      'ssnVerified': ssnVerified,
      'rapydId': rapydId
    };
    return result;
  }

  factory TrusterUser.fromJson(Map<String, dynamic> data) {
    return TrusterUser(
        uid: data['uid'],
        username: data['username'],
        email: data['email'],
        fcmToken: data['fcmToken'],
        fullName: data['fullName'],
        mobile: data['mobile'],
        countryCode: data['countryCode'],
        imageUrl: data['imageUrl'],
        ssnNumber: data['ssnNumber'],
        dob: DateTime.parse(data['dob']),
        dlImageUrl: data['dlImageUrl'],
        phoneVerified: data['phoneVerified'],
        ssnVerified: data['ssnVerified'],
        rapydId: data['rapydId']);
  }
}
