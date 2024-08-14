import 'dart:convert';
import 'package:flutterclass/repository/APIConstants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository{

  Future<int> login(String email, String password) async {
    var pref = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(APIConstant.LoginURL);

      // to serialize the data Map to JSON
      var body = json.encode({
        'email': email,
        'password': password
      });

      var response = await http.post(Uri.parse("http://192.168.0.116:8000/api/login"),
          headers: {"Content-Type": "application/json"},
          body: body
      );

      if (response.statusCode == 200) {
        // Parse the response body as JSON
        Map<String, dynamic> responseData = json.decode(response.body);

        // Extract the token from the response data
        // String token = responseData['token'];
        // int roleId = responseData["node_accesses"][0]["role_id"];
        // int userId = responseData["user"]["id"];
        //
        // // Store the token using shared preferences
        // pref.setString("token", token);
        // pref.setInt("roleId", roleId);
        // pref.setInt("userId", userId);
        // pref.setString("email", email);
        return 1;
      }

      return 0;
    } catch (e) {
      print(e.toString());
      return 2;
    }
  }

  Future<int> register(String username, String name, String email,
      String password, String confirmPassword, String phoneNumber, int roleId
      ) async{
    var pref = await SharedPreferences.getInstance();
    try{

      var url = Uri.parse(APIConstant.RegisterURL);

      var body = json.encode({
        "username": username,
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,
        "phone_number": phoneNumber,
        "role_id": roleId
      });

      print(body.toString());
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: body
      );

      if (response.statusCode == 200){
        String data =  response.body;
        pref.setString("token", data);
        return 0;
      }
      else {
        String data =  response.body;
        if(data[0] == 'U'){
          // username duplicated
          return 1;
        } else if (data[0] == 'E') {
          // email duplicated
          return 2;
        }
      }
      return 3;

    } catch (e) {
      print('error in register');
      print(e.toString());
      return 3;
    }
  }


  Future<bool> logout() async{
    var pref = await SharedPreferences.getInstance();
    try{
      var url = Uri.parse(APIConstant.LogoutURL);
      String? token = pref.getString('token');
      String? username = pref.getString('username');
      if (token != null){
        var header = {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}",
        };

        var response = await http.post(url, headers: header,);

        if (response.statusCode == 200) {
          pref.remove("token");
          return true;
        } else {
          print(response.statusCode);
          print(response.body.toString());
        }
      }
      return false;
    } catch (e) {
      print('error in logout');
      print(e.toString());
      return false;
    }
  }
}