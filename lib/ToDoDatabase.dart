//require package imports

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'ToDoDAO.dart';
import 'ToDoItem.dart';

part 'ToDoDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ToDoItem])
abstract class ToDoDatabase extends FloorDatabase {

  // get interface to database
  ToDoDAO get getDao;  // 1 variable for giving you access to insert, delete, update, query
}


// flutter packages pub run build_runner build
// flutter packages pub run build_runner watch  // for update