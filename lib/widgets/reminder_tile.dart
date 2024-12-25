import 'package:flutter/material.dart';
import '../model/reminder_item.dart';

class ReminderTile extends StatelessWidget {
  final Reminder reminderItem;
  final bool taskCompleted;
  final VoidCallback? onTap;
  final ValueChanged<bool?> onChanged;

  const ReminderTile({
    required this.reminderItem,
    required this.taskCompleted,
    required this.onChanged,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          reminderItem.title,
        ),
        subtitle: Text(reminderItem.notes),
        leading: SizedBox(
          width: 30,
          height: 30,
          child: Icon(reminderItem.category.icon),
        ),
        trailing: Checkbox(
          value: taskCompleted,
          onChanged: onChanged,
        ),
        onTap: onTap,
      );
    
  }
}
