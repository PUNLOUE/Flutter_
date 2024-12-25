import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/reminder_category.dart';
import '../model/reminder_item.dart';
import '../widgets/reminder_list.dart';
import 'package:uuid/uuid.dart';
import 'package:iconsax/iconsax.dart';

class NewTask extends StatefulWidget {
  final Mode mode;
  final Reminder? reminderList;

  const NewTask({
    super.key,
    this.mode = Mode.creating,
    this.reminderList,
  });

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _formKey = GlobalKey<FormState>();

  String id = const Uuid().v4();
  String _enterTitle = '';
  String _enterNote = '';
  ReminderCategory _category = ReminderCategory.others;
  DateTime? _selectedDate;

  //initial the old value to display on edit screeen
  @override
  void initState() {
    super.initState();

    if (widget.mode == Mode.editing && widget.reminderList != null) {
      final reminder = widget.reminderList!;
        _enterTitle = reminder.title;
        _enterNote = reminder.notes;
        _category = reminder.category;
        _selectedDate = reminder.dateTime;
      }
  }

  void onAdd() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Reminder newTask = Reminder(
        id: widget.reminderList?.id ?? id,
        title: _enterTitle,
        notes: _enterNote,
        dateTime: _selectedDate ?? DateTime.now(),
        category: _category,
      );

      Navigator.of(context).pop(newTask);
    }
  }

  void onReset() {
    _formKey.currentState!.reset();
    setState(() {
      _enterTitle = '';
      _enterNote = '';
      _category = ReminderCategory.others;
      _selectedDate = null;
    });
  }

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    return null;
  }

  void dateTimePickerWidget(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
        ).then((pickedTime) {
          if (pickedTime != null) {
            setState(() {
              _selectedDate = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
            });
          }
        });
      }
    });
  }

 Widget buildDateTimePickerButton() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 248, 248, 248),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        // Outer Shadow
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 5,
          spreadRadius: 1,
          offset: const Offset(5, 5),
        ),
        // Inner Shadow
        const BoxShadow(
          color: Colors.white,
          blurRadius: 5,
          spreadRadius: -15,
          offset: Offset(-5, -5),
        ),
      ],
    ),
    child: Material(
      color: const Color.fromARGB(0, 23, 239, 38),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          dateTimePickerWidget(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Center(
            child: Text(
              _selectedDate != null
                  ? DateFormat('dd-MMM-yyyy - HH:mm a').format(_selectedDate!)
                  : 'Pick Date-Time',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 51, 134, 81),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color:  Color.fromARGB(255, 249, 249, 249)),
        title:Text(widget.mode == Mode.editing ? 'Edit the Task' : 'Add New Task', style: const TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputCard(
                label: 'Title', 
                icon: Iconsax.pen_add, 
                child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter title",
                  border: InputBorder.none,
                ),
                  initialValue: _enterTitle,
                  validator: validateTitle,
                  onSaved: (value) {
                    _enterTitle = value!;
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildInputCard(
                label: "Notes", 
                icon: Iconsax.book1, 
                child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Optional",
                          border: InputBorder.none
                        ),
                        initialValue: _enterNote,
                        onSaved: (newValue) {
                          _enterNote = newValue!;
                        },
                      ),
              ),
              
              const SizedBox(height: 10),

              _buildInputCard(
                label: "Catogory", 
                icon: Iconsax.category, 
                child: DropdownButtonFormField<ReminderCategory>(
                  value: _category,
                  items: ReminderCategory.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Icon(category.icon),
                                const SizedBox(width: 10),
                                Text(category.name),
                              ],
                            ),
                          ))
                      .toList(),
                  decoration: const InputDecoration.collapsed(
                    hintText: '',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _category = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildInputCard(
                label: "Date time", 
                icon: Iconsax.calendar, 
                child: buildDateTimePickerButton()
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.mode == Mode.creating)
                    TextButton(
                      onPressed: onReset,
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: onAdd,
                      child: Text(widget.mode == Mode.editing ? 'Edit Task' : 'Add Task'),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }


   Widget _buildInputCard({
  required String label,
  required IconData icon,
  required Widget child,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        // Outer Shadow
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 20,
          spreadRadius: 25,
          offset: const Offset(20, 20),
        ),
        // Inverse Shadow (creates the inner shadow look)
        const BoxShadow(
          color: Colors.white,
          blurRadius: 20,
          spreadRadius: -25,
          offset: Offset(-20, -20),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color.fromARGB(255, 27, 209, 93)),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    ),
  );
}

}