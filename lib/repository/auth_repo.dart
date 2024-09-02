import 'dart:convert';
import 'package:flutterclass/repository/APIConstants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthRepository{

  Future<int> login(String email, String password) async {
    // this is a local storage
    var pref = await SharedPreferences.getInstance();
    try {

      //place your url here
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
        // String token = responseData['token'];
        // int roleId = responseData["node_accesses"][0]["role_id"];
        int userId = responseData["user"]["id"];
        //
        // // Store the token using shared preferences
        // pref.setString("token", token);
        // pref.setInt("roleId", roleId);
        pref.setInt("userId", userId);

        // pref.setString("email", email);
        return 1;
      }

      return 0;
    } catch (e) {
      print(e.toString());
      return 2;
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