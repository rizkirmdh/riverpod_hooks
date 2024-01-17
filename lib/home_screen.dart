import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_hooks/next_screen.dart';
import 'package:riverpod_hooks/providers/count/count.dart';
import 'package:riverpod_hooks/providers/provider.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(textProvider);
    final future = ref.watch(futureProvider);
    final stream = ref.watch(streamProvider);

    final state = ref.watch(stateProvider.notifier);

    final notifier = ref.watch(stateNotifierProvider.notifier);
    final change = ref.watch(changeNotifierProvider.notifier);

    final counter = ref.watch(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Hooks Example"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Text Provider: $text"),
            const SizedBox(
              height: 15,
            ),
            future.when(
                data: (config) {
                  return Text("Future Provider: ${config.toString()}");
                },
                error: (err, stack) => Text("Error: $err"),
                loading: () => CircularProgressIndicator()),
            const SizedBox(
              height: 15,
            ),
            stream.when(
                data: (config) {
                  return Text("Stream Provider: ${config.toString()}");
                },
                error: (err, stack) => Text("Error: $err"),
                loading: () => CircularProgressIndicator()),
            const SizedBox(
              height: 15,
            ),
            Text("State Provider: ${state.state}"),
            const SizedBox(
              height: 15,
            ),
            Text("Generator : ${counter.state}"),
            const SizedBox(
              height: 15,
            ),
            Text("StateNotifierProvider: ${notifier.state.toString()}"),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    notifier.add();
                  },
                  child: Text("add"),
                ),
                TextButton(
                  onPressed: () {
                    notifier.substract();
                  },
                  child: Text("substract"),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text("ChangeNotifierProvider: ${change.number}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      change.add();
                    },
                    child: Text("add")),
                TextButton(
                    onPressed: () {
                      change.substract();
                    },
                    child: Text("substract")),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NextScreen()));
                  },
                  child: Text("Next"),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // state.state++;
          counter.increment();
        },
        child: Text("State Provider Add +"),
      ),
    );
  }
}
