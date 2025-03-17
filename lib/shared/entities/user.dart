class User {
  final String id;
  final String fullName;
  final String accessToken;
  final String refreshToken;
  final String deviceToken;

  User({
    required this.fullName,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.deviceToken,
  });

  @override
  String toString() {
    return 'User{id: $id, name: $fullName, accessToken: $accessToken, refreshToken: $refreshToken}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      deviceToken: map['deviceToken'] as String,
    );
  }
}
