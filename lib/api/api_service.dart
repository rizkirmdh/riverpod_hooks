import 'dart:convert';

import 'package:http/http.dart';
import 'package:riverpod_hooks/model/user_model.dart';

class ApiService {
  String endpoint = "https://reqres.in/api/users?page=1";

  Future<List<UserModel>> getUser() async {
    Response response = await get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => UserModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  List<UserModel> getUserList() {
    List<UserModel> list = [
      UserModel(
          id: 0, email: "a", firstName: "a", lastName: "a", avatar: "avatar"),
      UserModel(
          id: 1, email: "b", firstName: "b", lastName: "b", avatar: "avatar")
    ];
    return list;
  }
}
