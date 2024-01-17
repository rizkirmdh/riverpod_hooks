import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/*
  Provider
 */
final textProvider = Provider<String>((ref) => "Agrio.id");

/*
  FutureProvider
 */
final futureProvider = FutureProvider<int>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return 5;
});

/*
  StreamProvider
 */
final streamProvider = StreamProvider<int>((ref) {
  return Stream.periodic(Duration(seconds: 2), (number) {
    if (number < 5) {
      return number + 1;
    } else {
      return 5;
    }
  });
});

/*
  StateProvider
 */
final stateProvider = StateProvider<int>((ref) => 2);

/*
  StateNotifierProvider
 */
final stateNotifierProvider =
    StateNotifierProvider<CountNotifier, int>((ref) => CountNotifier(5));

class CountNotifier extends StateNotifier<int> {
  CountNotifier(int state) : super(state);

  void add() {
    state += 1;
  }

  void substract() {
    state -= 1;
  }
}

/*
  ChangeNotifierProvider
 */
final changeNotifierProvider =
    ChangeNotifierProvider<ChangeCount>((ref) => ChangeCount());

class ChangeCount extends ChangeNotifier {
  int number = 10;

  void add() {
    number++;
    notifyListeners();
  }

  void substract() {
    number--;
    notifyListeners();
  }
}
