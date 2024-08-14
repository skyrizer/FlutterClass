class APIConstant {
  // wafir 10.131.77.251
  static const String ipaddress = "http://192.168.0.116:8000/";
  // static const String ipaddress = "http://10.131.75.244:8000/";

  static const String URL = "${ipaddress}api/";

  // auth module
  static String get LoginURL => "${APIConstant.URL}login";
  //static String get RegisterURL => "${APIConstant.URL}register";
  //static String get LogoutURL => "${APIConstant.URL}logout";

}
