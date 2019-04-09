import 'package:flutter/material.dart';
import 'package:note_app/NoteDetail.dart';
import 'dart:async';
import 'package:note_app/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:note_app/model/Note.dart';

class Notelist extends StatefulWidget {
  @override
  _NotelistState createState() => _NotelistState();
}

class _NotelistState extends State<Notelist> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Notekeeper"),
      ),
      body: listbuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB Clicked");
          naviagateToDetails(Note('', '', 2), 'Add Note');
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
                backgroundColor:
                    getPriorityColor(this.noteList[position].priority),
                child: getPriorityIcon(this.noteList[position].priority),
              ),
              title: Text(
                this.noteList[position].title,
                style: textStyle,
              ),
              subtitle: Text(this.noteList[position].date),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  delete(context, noteList[position]);
                },
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                naviagateToDetails(this.noteList[position], 'Edit Note');
              },
            ),
          );
        });
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deletNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void naviagateToDetails(Note note, String title) async {
    var result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  updateListView() {
    Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
