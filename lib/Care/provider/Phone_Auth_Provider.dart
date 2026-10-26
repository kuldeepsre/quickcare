import 'package:flutter/cupertino.dart';
import 'package:patientapp/Care/model/login_response.dart';
import 'package:patientapp/services/api_service.dart';

class PhoneAuthProvider extends ChangeNotifier{
  final ApiServices apiServices=ApiServices();
  bool _isloading=false;
  String ?_error;

  bool get isloading => _isloading;
  LoginResponse ? _loginResponse;

  String? get error => _error;

  LoginResponse ? get loginResponse => _loginResponse;

 Future<void>  postPhone({required phoneNo}) async{

   _isloading=true;
   _error=null;
   notifyListeners();
   try{

     _loginResponse=await apiServices.postNumber(phoneNo: phoneNo);


   }
   catch(e){
     _error=e.toString();
   }
   finally{
     _isloading=false;
     notifyListeners();
   }
 }
}