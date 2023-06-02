import 'package:cambridge_crud/models/priority.dart';
import 'package:cambridge_crud/models/todo.dart';
import 'package:cambridge_crud/providers/todo_provider.dart';
import 'package:cambridge_crud/widgets/custom_alertdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cambridge_crud/widgets/listViews/todo_listView.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final stringProvider = StateProvider((ref) => 'hello world!');

  @override
  Widget build(BuildContext context) {
    final todoList = ref.watch(todoProvider);

    Future<void> showTodoDialog() async {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) => CustomAlertDialog()
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
                onPressed: () {
                  showTodoDialog();
                },
                icon: const Icon(Icons.add)),
          )
        ],
      ),
      body: todoList.isEmpty
          ? const Center(
              child: Text('no data yet.'),
            )
          : const TodoListView(),
    );
  }
}
