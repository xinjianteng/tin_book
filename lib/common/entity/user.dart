// 注册请求
class UserRegisterRequestEntity {
  String username;
  String email;
  String password;

  UserRegisterRequestEntity({
    required this.username,
    required this.email,
    required this.password,
  });

  factory UserRegisterRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserRegisterRequestEntity(
        username: json["username"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };
}

// 注册返回
class UserRegisterResponseEntity {
  String? objectId;
  String? sessionToken;
  String? createdAt;

  UserRegisterResponseEntity({
    this.objectId,
    this.sessionToken,
    this.createdAt,
  });


  factory UserRegisterResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserRegisterResponseEntity(
        objectId: json["objectId"],
        sessionToken: json["sessionToken"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
    "objectId": objectId,
    "sessionToken": sessionToken,
    "createdAt": createdAt,
  };
}


// 登录请求
class UserLoginRequestEntity {
  String username;
  String password;

  UserLoginRequestEntity({
    required this.username,
    required this.password,
  });

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}

// 登录返回
class UserLoginResponseEntity {
  String? objectId;
  String? createdAt;
  String? sessionToken;
  String? updatedAt;
  String? username;

  UserLoginResponseEntity({
    this.objectId,
    this.createdAt,
    this.sessionToken,
    this.updatedAt,
    this.username,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        objectId: json["objectId"],
        createdAt: json["createdAt"],
        sessionToken: json["sessionToken"],
        updatedAt: json["updatedAt"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "createdAt": createdAt,
        "sessionToken": sessionToken,
        "updatedAt": updatedAt,
        "username": username,
      };
}

