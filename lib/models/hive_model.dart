import 'dart:convert';

class Notes{
  String? noteTime;
  String? content;
  Notes({this.content,this.noteTime});
  Notes.fromJson(Map<String, dynamic>json)
      :noteTime = json['noteTime'],
        content = json['content'];
  Map <String,dynamic> toJson()=>{
    'noteTime':noteTime,
    'content':content,
  };
  static String encode(List<Notes> notes) => json.encode(
      notes.map<Map<String, dynamic>>((note) => note.toJson()).toList());

  static List<Notes> decode(String notes) =>
      json.decode(notes).map<Notes>((item) => Notes.fromJson(item)).toList();
}