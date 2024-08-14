class APIConstant {
  // wafir 10.131.77.251
  static const String ipaddress = "http://192.168.0.116:8000/";
  // static const String ipaddress = "http://10.131.75.244:8000/";

  //static const String URL = "${ipaddress}api/";
  //static const String URL = "${ipaddress}";


  // auth module
  static String get LoginURL => "${APIConstant.ipaddress}login";
  static String get RegisterURL => "${APIConstant.ipaddress}register";
  static String get LogoutURL => "${APIConstant.ipaddress}logout";

}
