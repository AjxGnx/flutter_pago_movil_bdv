import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pago_movil_bdv/models/Contact.dart';

class DatabaseClient {
  Database _db;

  Future<Database> create() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "database.db");

    _db = await openDatabase(dbPath, version: 1,
        onCreate: this._create);

    return _db;
  }


  Future _create(Database db, int version) async {
    await db.execute("""
            CREATE TABLE contact (
              id INTEGER PRIMARY KEY, 
              name TEXT NOT NULL,
              phone TEXT NOT NULL,
              codeBank TEXT NOT NULL,
              dni TEXT NOT NULL
            )""");
  }

  Future<ContactModel> upsertContact(ContactModel contact) async {
    var count = Sqflite.firstIntValue(await _db.rawQuery("SELECT COUNT(*) FROM contact WHERE name = ?", [contact.name]));
    if (count == 0) {
      contact.id = await _db.insert("contact", contact.toMap());
    } else {
      await _db.update("contact", contact.toMap(), where: "id = ?", whereArgs: [contact.id]);
    }

    return contact;
  }

  Future<List<ContactModel>> getContact() async {
    List<Map> results = await _db.query("contact", columns: ContactModel.columns, orderBy: "id DESC");

    List<ContactModel> contacts = new List();
    results.forEach((result) {
      ContactModel contact = ContactModel.fromMap(result);
      contacts.add(contact);
    });


    return contacts;
  }

  Future<int> deleteContact() async {
    return await _db.rawDelete('DELETE FROM contact');
  }

}

