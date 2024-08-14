import 'dart:convert';
import 'package:containsafe/repository/APIConstant.dart';
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

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: body
      );

      if (response.statusCode == 200) {
        // Parse the response body as JSON
        Map<String, dynamic> responseData = json.decode(response.body);

        // Extract the token from the response data
        String token = responseData['token'];
        int roleId = responseData["node_accesses"][0]["role_id"];
        int userId = responseData["user"]["id"];

        // Store the token using shared preferences
        pref.setString("token", token);
        pref.setInt("roleId", roleId);
        pref.setInt("userId", userId);
        pref.setString("email", email);
        return 1;
      }

      return 0;
    } catch (e) {
      print(e.toString());
      return 2;
    }
  }

  Future<bool> refreshToken() async{
    var pref = await SharedPreferences.getInstance();
    try{
      var url = Uri.parse(APIConstant.RefreshURL);
      String? email = pref.getString('email');
      String? token = pref.getString('token');

      if (email != null){
        var header = {
          "Content-Type": "application/json",
          "email" : email,
          'Authorization': "Bearer ${token}",
        };

        var response = await http.put(url, headers: header,);

        if (response.statusCode == 200) {
          print('New token received');
          String data = response.body;
          Map<String, dynamic> jsonData = json.decode(data);
          String token = jsonData['token']; // Extracting the token value
          print('Token: $token');
          pref.setString("token", token); // Saving the token to preferences
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      print('error');
      print(e.toString());
      return false;
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

  Future<bool> sendEmail(String email) async{
    try{
      var url = Uri.parse(APIConstant.ForgotPasswordURL + "?email=" + email);
      print(url.toString());
      var response = await http.post(url);

      if (response.statusCode == 200){
        return true;
      } else {
        //   status code == 400
        print('invalid email');
      }
      return false;
    } catch (e){
      print('error in send email for forgot password');
      print(e.toString());
      return false;
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