import 'package:flutter/material.dart';
import '../model/reminder_item.dart';
import '../widgets/reminder_tile.dart';
import '../widgets/reminder_form.dart';
import 'package:iconsax/iconsax.dart';

enum Mode {
  creating,
  editing,
}
class ReminderList extends StatefulWidget {
  const ReminderList({
    super.key,
    required this.tasks,
    required this.onRemovedTask,
    required this.completedTasks,
  });

  final List<Reminder> tasks;
  final List<Reminder> completedTasks;
  final Function(Reminder) onRemovedTask;

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      widget.tasks[index].taskCompleted = value ?? false;

      if (widget.tasks[index].taskCompleted) {
        Reminder completedTask = widget.tasks.removeAt(index);
        widget.completedTasks.add(completedTask);
      }
    });
  }

  void _editTask(Reminder item, int index) async {
    final updatedTask = await Navigator.of(context).push<Reminder>(
      MaterialPageRoute(
        builder: (ctx) => NewTask(
          mode: Mode.editing,
          reminderList: item,
        ),
      ),
    );

    if (updatedTask != null) {
      setState(() {
        int taskIndex = widget.tasks.indexWhere((task) => task.id == updatedTask.id);
        if (taskIndex != -1) {
          widget.tasks[taskIndex] = updatedTask;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.tasks.isNotEmpty
        ? ListView.builder(
            itemCount: widget.tasks.length,
            itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                color: const Color.fromARGB(255, 27, 209, 93),
                // ignore: sort_child_properties_last
                child: const Icon(Iconsax.trash, color: Colors.white,),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
              ),
              key: UniqueKey(),
              confirmDismiss: (direction) async{
                return _showDeleteComfirmationDialog(context);
              },
              onDismissed: (direction) {
                setState(() {
                  widget.tasks.removeAt(index);
                });
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Task deleted'),
                    duration: Duration(seconds: 3)
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                
                child: ReminderTile(
                  reminderItem: widget.tasks[index],
                  taskCompleted: widget.tasks[index].taskCompleted,
                  onChanged: (value) {
                    checkBoxChanged(value, index);
                  },
                  onTap: () => _editTask(widget.tasks[index], index),
                ),
              ),
            ),
          )
        : const Center(
            child: Text('No tasks yet'),
          );
  }

  Future<bool?> _showDeleteComfirmationDialog(BuildContext context){
    return showDialog<bool>(
      context: context, 
      builder: (BuildContext content){
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Delete Reminders task'),
          content: const Text('Are you sure, you want to delete this task'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(false);
              }, 
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(true);
              }, 
              child: const Text("Delete", style: TextStyle(color: Color.fromARGB(255, 27, 209, 93)),),
            )
          ],
        );
      }
    );
  }
}