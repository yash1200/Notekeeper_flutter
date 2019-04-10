import 'package:flutter/material.dart';
import 'dart:async';
import 'package:note_app/utils/database_helper.dart';
import 'package:note_app/model/Note.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  NoteDetailState createState() => NoteDetailState(this.note, this.appBarTitle);
}

class NoteDetailState extends State<NoteDetail> {
  var priorities = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String appBarTitle;
  Note note;

  NoteDetailState(this.note, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.title;
    titleController.text = note.title;
    descController.text = note.desc;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
            child: ListTile(
              title: DropdownButton(
                  items: priorities.map((String dropdownitem) {
                    return DropdownMenuItem<String>(
                      value: dropdownitem,
                      child: Text(dropdownitem),
                    );
                  }).toList(),
                  style: textstyle,
                  value: getPriorityAsString(note.priority),
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      debugPrint("User Selected $valueSelectedByUser");
                      updatePriorityAsInt(valueSelectedByUser);
                    });
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextField(
              controller: titleController,
              style: textstyle,
              onChanged: (value) {
                debugPrint("Something in the textfield");
                updateTitle();
              },
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: textstyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: TextField(
              controller: descController,
              style: textstyle,
              onChanged: (value) {
                debugPrint("Something in the textfield");
                updateDesc();
              },
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: textstyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    elevation: 2,
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Save",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        debugPrint("Save Clicked");
                        _save();
                      });
                    },
                  ),
                ),
                Container(
                  width: 5,
                ),
                Expanded(
                  child: RaisedButton(
                    elevation: 2,
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Delete",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        debugPrint("Delete Clicked");
                        _delete();
                      });
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = priorities[0];
        break;
      case 2:
        priority = priorities[1];
        break;
    }
    return priority;
  }

  void updateTitle() {
    note.title = titleController.text;
    print(titleController.text);
  }

  void updateDesc() {
    note.desc = descController.text;
    print(titleController.text);
  }

  void _save() async {
    int result;
    Navigator.pop(context, true);
    note.date = DateFormat.yMMMd().format(DateTime.now());
    print(note.id);
    print(note.date);
    print(note.title);
    print(note.desc);
    print(note.priority);
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    Navigator.pop(context, true);
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was Deleted');
    }
    int result = await helper.deletNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Some Error Occured');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
