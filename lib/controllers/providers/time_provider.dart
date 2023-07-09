import 'package:flutter/material.dart';
import 'package:todo_app_flutter/modals/todo_modal.dart';

class TimeProvider extends ChangeNotifier {
  TodoModal todoModal = TodoModal(Time: 9, Note: 'AM');

  increment() {
    if (todoModal.Time == 7 && todoModal.Note == 'PM') {
      todoModal.Time = 7;
      todoModal.Note = 'PM';
    } else if (todoModal.Time < 12) {
      ++todoModal.Time;
    } else {
      todoModal.Time = 0;
      ++todoModal.Time;
      todoModal.Note = 'PM';
    }
    notifyListeners();
  }
}
