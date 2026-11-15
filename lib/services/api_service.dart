import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:patientapp/Care/model/login_response.dart';

class ApiServices {
  static const String baseUrl = "https://yourapi.com/api";
  static const String loginEndpoint = "$baseUrl/auth/login";
  static const String verifyOtpEndpoint = "$baseUrl/auth/verify-otp";
Future<LoginResponse>  postNumber({required phoneNo}) async{
  final response=await http.post(Uri.parse(loginEndpoint),
  headers: {
    "Content-Type":"application/json",
  },

    body: jsonEncode(
      {
        "phoneNo":phoneNo
      }
    )
  );
  if(response.statusCode==200||response.statusCode==201){
    Map<String,dynamic>  json=jsonDecode(response.body);
    return LoginResponse.fromJson(json);
  }

  else{
    throw Exception("Failed Login");
  }

}

}