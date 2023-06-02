import 'package:flutter/material.dart';

enum Priorities {
  low,
  medium,
  high
}

const priorityList = {
  Priorities.low: Priority('low priority', Colors.green),
  Priorities.medium: Priority('medium priority', Colors.yellow),
  Priorities.high: Priority('high priority', Colors.red),

};

class Priority {
  final String title;
  final Color color;

  const Priority(this.title, this.color);
}