// ignore_for_file: avoid_types_as_parameter_names
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:notes_app_using_have/models/hive_model.dart';

class HiveDB{
  static String DB_NAME= "notes App";
  static var box =  Hive.box(DB_NAME);
 static storeNotes(list)async{
   box.put("Notes", list);
 }
  static Notes getNotedBox() {
   var notes = Notes.fromJson(box.get('notes'));
   return notes;
  }
 }


//
// static  storeNotes(list) async{
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('notes', list);
// }
//
// static Future<String?> loadNotes()async {
// SharedPreferences prefs = await SharedPreferences.getInstance();
// return prefs.getString('notes');
// }
