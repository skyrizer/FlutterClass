class APIConstant {
  // wafir 10.131.77.251
  static const String ipaddress = "http://192.168.0.122:8000/";
  // static const String ipaddress = "http://10.131.75.244:8000/";

  //static const String URL = "${ipaddress}api/";
  //static const String URL = "${ipaddress}";


  // authentication module
  static String get LoginURL => "${APIConstant.ipaddress}login";
  static String get RegisterUserURL => "${APIConstant.ipaddress}registerUser";
  static String get LogoutURL => "${APIConstant.ipaddress}logout";

  // user
  static String get GetUsersURL => "${APIConstant.ipaddress}allUser";
  static String get UpdateUserURL => "${APIConstant.ipaddress}updateUser";



}
