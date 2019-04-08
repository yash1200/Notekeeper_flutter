import 'package:flutter/material.dart';
import 'package:note_app/NoteDetail.dart';

class Notelist extends StatefulWidget {
  @override
  _NotelistState createState() => _NotelistState();
}

class _NotelistState extends State<Notelist> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notekeeper"),
      ),
      body: listbuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB Clicked");
          naviagateToDetails('Add Note');
        },
        child: Icon(Icons.add),
        tooltip: 'Add Note',
      ),
    );
  }

  listbuilder() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text(
                "Dummy Title",
                style: textStyle,
              ),
              subtitle: Text("Dummy Date"),
              trailing: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                naviagateToDetails('Edit Note');
              },
            ),
          );
        });
  }

  naviagateToDetails(String title)
  {
    return Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetail(title);
    }));
  }
}
