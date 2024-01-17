import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_hooks/profile_screen.dart';
import 'package:riverpod_hooks/providers/user/get_user.dart';

class NextScreen extends HookConsumerWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userDataProvider);

    final userDataList = ref.watch(userDataListProvider);

    final changeUserData = ref.watch(changeUserDataProvider.notifier);

    inspect(userDataList.value);
    inspect(userData);

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "User Data",
            ),
          ),
          actions: [
            GestureDetector(
              child: Icon(Icons.add),
              onTap: () {
                changeUserData.add();
              },
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              child: Icon(Icons.person_rounded),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
          ],
        ),
        body: Container(
            margin: const EdgeInsets.all(8),
            child: RefreshIndicator(
                onRefresh: () => ref.refresh(userDataListProvider.future),
                child: userData.when(
                    data: (config) {
                      return ListView.builder(
                        itemCount: config.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(config[index].avatar),
                            ),
                            title: Text(
                                "${config[index].firstName} ${config[index].lastName}"),
                            subtitle: Text(config[index].email),
                          );
                        },
                      );
                    },
                    error: (err, stack) => Text("Error: $err"),
                    loading: () =>
                        const Center(child: CircularProgressIndicator())))));

    // userDataList.when(
    //       data: (config) {
    //         return ListView.builder(
    //           itemCount: config.length,
    //           itemBuilder: (_, index) {
    //             return ListTile(
    //               leading: CircleAvatar(
    //                 backgroundImage: NetworkImage(config[index].avatar),
    //               ),
    //               title: Text(
    //                   "${config[index].firstName} ${config[index].lastName}"),
    //               subtitle: Text(config[index].email),
    //             );
    //           },
    //         );
    //       },
    //       error: (err, stack) => Text("Error: $err"),
    //       loading: () => const Center(child: CircularProgressIndicator()))
  }
}
