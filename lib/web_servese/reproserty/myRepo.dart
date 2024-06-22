



import 'package:anbobtak/web_servese/dio/web_serv.dart';
import 'package:anbobtak/web_servese/model/username.dart';

class MyRepo {
  final NameWebServise nameWebService;

  MyRepo(this.nameWebService);

  Future<List<User>> getAllUsers(String end) async {
    final names = await nameWebService.get(end);
    final userList = names.map((names) => User.fromJson(names)).toList();
    return userList..shuffle();
  }



  Future<String> login(String end, Object data ) async {
    try {
      final result = await nameWebService.LoginDio(end, data);

      if (result.isNotEmpty) {
        // final userid = result.map((result) => User.fromJson(result)).toList();
        dynamic firstItem = result[1];
        int userId = firstItem['user_id'];
        String userIdAsString = userId.toString();
        print('login $userIdAsString');
        return userIdAsString;
      } else {
        throw Exception("Invalid response format: Empty response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }

  Future<String> SignUpUser(String end, Object data) async {
    try {
      final result = await nameWebService.SignUpDio(end, data);

      if (result.isNotEmpty) {
        // final userid = result.map((result) => User.fromJson(result)).toList();
        dynamic firstItem = result[0];
        int userId = firstItem['user_id'];
        String userIdAsString = userId.toString();
        print('signUp $userIdAsString');
        return userIdAsString;
      } else {
        throw Exception("Invalid response format: Empty response");
      }
    } catch (e) {
      print("Error during login: ${e.toString()}");
      throw Exception("Failed to login. Please try again.");
    }
  }


}
