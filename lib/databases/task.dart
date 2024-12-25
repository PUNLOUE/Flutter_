import '../model/reminder_category.dart';
import '../model/reminder_item.dart';


final reminderTask = [
  Reminder(
    id: '', 
    title: 'Reading Manga', 
    notes: 'read the 1 or 2 chapter', 
    dateTime: DateTime.now(), 
    category: ReminderCategory.miscellaneous
  ),
  Reminder(
    id: '', 
    title: 'At Counddown Night', 
    notes: 'Play game with friend', 
    dateTime: DateTime.now(), 
    category: ReminderCategory.social
  )
];