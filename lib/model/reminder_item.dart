import '../model/reminder_category.dart';
import 'package:uuid/uuid.dart';

class Reminder {
   Reminder({
    required this.id,
    required this.title,
    required this.notes,
    required this.dateTime,
    required this.category,
    this.taskCompleted = false,
  });

  String id = const Uuid().v4();
  final String title;
  final String notes;
  final DateTime dateTime;
  final ReminderCategory category;
  bool taskCompleted;
}
