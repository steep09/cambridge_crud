import 'dart:ui';

import 'package:cambridge_crud/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cambridge_crud/models/priority.dart';
import 'package:cambridge_crud/models/todo.dart';

class CustomAlertDialog extends ConsumerStatefulWidget {
  CustomAlertDialog({super.key, this.todoItem, this.edit = false});

  Todo? todoItem;
  bool edit;

  @override
  ConsumerState<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends ConsumerState<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var enteredTitleText = '';
    var enteredTitleDescription = '';
    var selectedPriority =
        widget.todoItem?.priority ?? priorityList[Priorities.low];

    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: AlertDialog(
          // <-- SEE HERE
          title: widget.edit ? const Text('Edit Task') : const Text('New Task'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.todoItem?.title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      label: const Text('title'),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 1) {
                        return 'required field';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        enteredTitleText = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    initialValue: widget.todoItem?.description,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: const Text('description'),
                    ),
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        enteredTitleDescription = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  DropdownButtonFormField(
                    value: selectedPriority,
                    items: [
                      for (final priority in priorityList.entries)
                        DropdownMenuItem(
                          value: priority.value,
                          child: Row(
                            children: [
                              Container(
                                height: 10.0,
                                width: 10.0,
                                decoration:
                                    BoxDecoration(color: priority.value.color),
                              ),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Text(priority.value.title),
                            ],
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      selectedPriority = value!;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(widget.edit ? 'Save' : 'Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (widget.edit) {
                    ref.read(todoProvider.notifier).editTodo(
                          widget.todoItem!,
                          Todo(
                              title: enteredTitleText,
                              priority: selectedPriority!,
                              description: enteredTitleDescription),
                        );
                  } else {
                    ref.read(todoProvider.notifier).addTodo(Todo(
                        title: enteredTitleText,
                        priority: selectedPriority!,
                        description: enteredTitleDescription));
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
