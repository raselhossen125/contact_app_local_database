// ignore_for_file: unused_field, unused_local_variable, unnecessary_string_interpolations

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import '../models/contact_model.dart';

class DBHelper {
  static const _createTableContact = '''
  create table $tableContact(
  $tableContactColId integer primary key,
  $tableContactColName text,
  $tableContactColNumber text,
  $tableContactColEmail text,
  $tableContactColaAddress text,
  $tableContactColDob text,
  $tableContactColGender text,
  $tableContactColImage text,
  $tableContactColWebsite text,
  $tableContactColFav integer
  )
  ''';

  static Future<Database> open() async {
    final root = await getDatabasesPath();
    final dbPath = path.join(root, 'contact.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(_createTableContact);
    });
  }

  static Future<int> insertContact(ContactModel contactModel) async {
    final db = await open();
    return db.insert(tableContact, contactModel.toMap());
  }

  static Future<List<ContactModel>> getAllContacts() async {
    final db = await open();
    final List<Map<String, dynamic>> mapList =
        await db.query(tableContact, orderBy: '$tableContactColName');
    return List.generate(
        mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }
}
