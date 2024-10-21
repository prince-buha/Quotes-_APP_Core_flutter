import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:quotes_app/modules/screens/quote_page/model/quote_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  static Database? database;

  //TODO:table componennts
  String table_name = 'quote';
  String id = 'id';
  String quote = 'quote';
  String category = 'category';

  initDB() async {
    String path = await getDatabasesPath();
    String db_path = join(path, 'demo.db');

    database = await openDatabase(
      db_path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE IF NOT EXISTS $table_name($id INTEGER PRIMARY KEY AUTOINCREMENT,$quote TEXT,$category TEXT);";
        db.execute(query);
      },
    );
  }

  Future<int?> insertQuote({required QuoteModel m_quote}) async {
    await initDB();
    String query = "INSERT INTO $table_name($quote,$category) VALUES(?,?);";
    List args = [m_quote.quote, m_quote.category];
    int? res = await database?.rawInsert(query, args);
    return res;
  }

  Future<List<QuoteModel>?> fetchQuote() async {
    await initDB();
    String query = "SELECT * FROM $table_name;";
    var list = await database?.rawQuery(query);
    List<QuoteModel>? todo =
        list?.map((e) => QuoteModel.fromDB(data: e)).toList();
    return todo;
  }

  Future<void> deleteStudentData(int dId) async {
    database = await initDB();

    String sql = 'DELETE FROM Student WHERE $id=?';

    List args = [dId];

    await database!.rawDelete(sql, args).then((value) {
      Get.snackbar('Delete', 'Student Data Deleted',
          backgroundColor: Colors.red.shade200.withOpacity(0.5),
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
