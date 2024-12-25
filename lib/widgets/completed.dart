import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/reminder_item.dart';

class CompletedScreen extends StatelessWidget {
  final List<Reminder> completedTasks;

  const CompletedScreen({Key? key, required this.completedTasks}) : super(key: key);

  void onTap(BuildContext context, Reminder completedTask) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Task Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(completedTask.title),
              ),
              ListTile(
                title: const Text('Notes:', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(completedTask.notes),
              ),
              ListTile(
                title: const Text('Date:', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(DateFormat('dd-MMM-yyyy - HH:mm a').format(completedTask.dateTime)),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close', style: TextStyle(color: Color.fromARGB(255, 27, 209, 93))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No completed tasks yet'));

    if (completedTasks.isNotEmpty) {
      content = ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (ctx, index) {
          final task = completedTasks[index];

          return Card(
            color: Colors.white,
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(task.title),
              subtitle: Text(DateFormat('dd-MMM-yyyy - HH:mm a').format(task.dateTime)),
              leading: SizedBox(
                width: 30,
                height: 30,
                child: Icon(task.category.icon),
              ),
              trailing: const Icon(Icons.check_circle_outline, color: Colors.green),
              onTap: () {
                onTap(context, task);
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
      ),
      body: content,
    );
  }
}