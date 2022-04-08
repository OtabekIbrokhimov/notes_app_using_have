import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes_app_using_have/models/hive_model.dart';
import 'package:notes_app_using_have/servises/hive_servise.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
static const String id = "/Homepage";
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List <Notes> list  = [];
  bool isSelected = false;
  final textControlle = TextEditingController();
  void saveNotes()async{
    String datey = textControlle.text.toString().trim();
    list.add(Notes(noteTime: DateTime.now().toString().substring(0,16),content: datey));
    _loadInfo();
    print(list);}
    void _loadInfo()async{
    String notes =Notes.encode(list);
    HiveDB.storeNotes(notes);
    list = Notes.decode( HiveDB.getNotedBox() as String);
    }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          "Notes",
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(

          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return _notes(index);
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);

                        },
                        child: Text(
                          "cancel",
                        )),
                    TextButton(
                        onPressed: () {
                          saveNotes();
                          Navigator.pop(context);
                          textControlle.clear();

                          setState(() {

                          });
                          textControlle.clear();
                        },
                        child: Text(
                          "save",
                        )),
                  ],
                  title: Text(
                    "New Note",
                    style: TextStyle(color: Colors.grey),
                  ),
                  content: TextFormField(
                    controller: textControlle,
                    decoration: InputDecoration(
                        hintText: 'Enter your note', border: InputBorder.none),
                  ),
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  Widget _notes(int index) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: (BuildContext context) {
              list.removeAt(index);
            _loadInfo();
              setState(() {});
            },
            icon: Icons.delete,
          ),
          SlidableAction(
              backgroundColor: Colors.blue,
              onPressed: (BuildContext context) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        title: Text(
                          "New Note",
                          style: TextStyle(color: Colors.grey),
                        ),
                        content: TextField(
                          controller: textControlle..text = list[index].content!,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: "Enter your note!",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "CANCEL",
                                style: TextStyle(
                                    color: Colors.greenAccent, fontSize: 16),
                              )),
                          TextButton(
                              onPressed: () {
                                list[index].content = textControlle.text;
                                list[index].noteTime = DateTime.now().toString();
                                _loadInfo();
                                Navigator.pop(context);
                                textControlle.clear();
                                setState(() {});
                              },
                              child: const Text(
                                "SAVE",
                                style: TextStyle(
                                    color: Colors.greenAccent, fontSize: 16),
                              )),
                        ],
                      );
                    });
              },
              icon: Icons.edit),
        ],
      ),
      child:ListTile(
        onLongPress: (){
          setState(() {

          });
          //selecting = !selecting;
        },
        subtitle: Text(list[index].content.toString(),style: TextStyle(color: Colors.black, fontSize: 15),),
        title: Text(list[index].noteTime!,style: TextStyle(fontSize: 10, color: Colors.black,fontWeight: FontWeight.bold),),
      //
        //  trailing: selecting?IconButton(onPressed: (){list[index].isSelected = list[index].isSelected;}, icon:list[index].isSelected==false?Icon(Icons.check_circle_outline_outlined):Icon(Icons.check_circle_sharp)):Container(height: 5,width: 5,),
        leading: Container(
          margin: EdgeInsets.all(15),
          child: CircleAvatar(
            radius: 5,

            backgroundColor: Colors.grey,
          ),),
      ),
    );
  }
}
