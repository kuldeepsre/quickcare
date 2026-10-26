class LoginResponse {

  final int phoneNo;

  LoginResponse({
    required this.phoneNo,

  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      phoneNo: json['phoneNo'],

    );
  }
}