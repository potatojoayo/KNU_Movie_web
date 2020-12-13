import 'log.dart';

class User {
  static String email;
  static String password;
  static String fname;
  static String lname;
  static int uid;
  static String sex;
  static String birthday;
  static String phone;
  static String address;
  static String job;
  static int sid;
  static bool isAdmin;
  static List<Log> myLogs;
  static void logout() {
    email = password = fname = lname =
        uid = sex = birthday = phone = address = job = sid = isAdmin = null;
  }
}
