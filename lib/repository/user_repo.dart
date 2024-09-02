import 'dart:convert';
import 'package:flutterclass/repository/APIConstants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/User.dart';

class UserRepository{

  Future<List<User>> getAllUsers() async {
    try {
      var pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");

      var url = Uri.parse(APIConstant.GetUsersURL);

      var header = {
        "Content-Type": "application/json",
      };

      var response = await http.get(url, headers: header);

      if (response.statusCode == 200) {

        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> jsonData = responseData['users'];

        List<User> users = jsonData.map((data) => User.fromJson(data)).toList();

        return users;
      } else {
        print("Failed to load users. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error in getting all users: $e");
      return [];
    }
  }

  Future<int> registerUser(String name, String email, String password, String passwordConfirmation, String address) async {

    try {

      var url = Uri.parse(APIConstant.RegisterUserURL);
      late String body; // Declare body variable

        body = json.encode({
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "address": address,

        });

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // String data =  response.body;
        // pref.setString("token", data);
        return 0;
      } else if (response.statusCode == 302) {
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      print('error in add node');
      print(e.toString());
      return 3;
    }
  }

  Future<int> updateUser(int userId, String name, String email, String address) async {

    try {
      var url = Uri.parse(APIConstant.UpdateUserURL);
      late String body; // Declare body variable

      body = json.encode({
        "userId": userId,
        "name": name,
        "email": email,
        "address": address,

      });

      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // String data =  response.body;
        // pref.setString("token", data);
        return 0;
      } else if (response.statusCode == 302) {
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      print('error in add node');
      print(e.toString());
      return 3;
    }
  }




}