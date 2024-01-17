import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_hooks/api/api_service.dart';
import 'package:riverpod_hooks/model/user_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final userDataProvider = FutureProvider<List<UserModel>>((ref) {
  return ref.read(apiServiceProvider).getUser();
});

final userDataListProvider = FutureProvider<List<UserModel>>((ref) {
  return ref.read(apiServiceProvider).getUserList();
});

final changeUserDataProvider = ChangeNotifierProvider((ref) => ChangeData());

class ChangeData extends ChangeNotifier {
  List<UserModel> list = [
    UserModel(
        id: 0, email: "a", firstName: "a", lastName: "a", avatar: "avatar"),
    UserModel(
        id: 1, email: "b", firstName: "b", lastName: "b", avatar: "avatar")
  ];

  void add() {
    list.add(UserModel(
        id: 3, email: "c", firstName: "c", lastName: "c", avatar: "avatar"));
    notifyListeners();
  }
}
