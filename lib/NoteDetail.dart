import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  String appBarTitle;
  NoteDetail(this.appBarTitle);
  @override
  NoteDetailState createState() => NoteDetailState(this.appBarTitle);
}

class NoteDetailState extends State<NoteDetail> {
  var priorities = ['High', 'Low'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String appBarTitle;
  NoteDetailState(this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.title;
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
                  value: 'Low',
                  onChanged: (valueSelectedByUser) {
                    setState(() {
                      debugPrint("User Selected $valueSelectedByUser");
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
                      });
                    },
                  ),
                ),
                Container(width: 5,),
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
}
