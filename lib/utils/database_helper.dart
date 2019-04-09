import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:note_app/model/Note.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable='note_table';
  String colId='id';
  String colTitle='title';
  String colDesc='desc';
  String colDate='date';
  String colPriority='priority';


  DatabaseHelper._createInstance();
  factory DatabaseHelper(){
    if(_databaseHelper==null)
      {
        _databaseHelper=DatabaseHelper._createInstance();
      }
      return _databaseHelper;
  }

  Future<Database> get database async{
    if(_database==null)
      {
        _database=await initializeDatabase();
      }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory directory=await getApplicationDocumentsDirectory();
    String path=directory.path+'notes.db';
    var notesDatabase=await openDatabase(path,version: 1,onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db,int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDesc TEXT,$colPriority INTEGER,$colDate TEXT)');
  }

  Future<List<Map<String,dynamic>>> getNoteMapList() async{
    Database db=await this.database;
    var result=await db.query(noteTable,orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> insertNote(Note note) async{
    Database db=await this.database;
    var result=await db.insert(noteTable, note.toMap());
  }

  Future<int> updateNote(Note note) async{
    var db=await this.database;
    var result=await db.update(noteTable, note.toMap(),where: '$colId=?',whereArgs: [note.id]);
    return result;
  }
  
  Future<int> deletNote(int id) async{
    var db=await this.database;
    var result=await db.rawDelete('SELECT FORM $noteTable WHERE $colId=$id');
    return result;
  }

  Future<int> getCount() async{
    var db=await this.database;
    List<Map<String,dynamic>> x=await db.rawQuery('SELECT COUNT (*) FROM $noteTable');
    int result=Sqflite.firstIntValue(x);
    return result;
  }

}