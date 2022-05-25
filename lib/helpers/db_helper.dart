import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'tea_buyer.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE customer(id TEXT PRIMARY KEY, name TEXT,address TEXT,dateofbirth TEXT,contact TEXT,email TEXT,accountnumber TEXT,image TEXT)');
        await db.execute(
            'CREATE TABLE business(name TEXT PRIMARY KEY,address TEXT,contact TEXT,email TEXT,password TEXT)');
        await db.execute(
            'CREATE TABLE fertilizer(name TEXT PRIMARY KEY,type TEXT,unitprice REAL,storeamount REAL,image TEXT)');
        await db.execute(
            'CREATE TABLE supplykillo(id TEXT PRIMARY KEY,customerid TEXT,date TEXT,time TEXT,amount REAL,numberofbages REAL)');
        await db.execute(
            'CREATE TABLE advancepayment(id TEXT PRIMARY KEY,customerid TEXT,date TEXT,time TEXT,amount REAL,description TEXT)');
        await db.execute(
            'CREATE TABLE purchesfertilizercost(id TEXT PRIMARY KEY,customerid TEXT,date TEXT,time TEXT,fertilizertype TEXT,amount REAL,price REAL)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String tabel, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      tabel,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(String tabel, Map<String, Object> data, String id,
      String customerId) async {
    final db = await DBHelper.database();
    db.update(tabel, data,
        where: 'id = ? AND customerid = ?', whereArgs: [id, customerId]);
  }

  static Future<void> delete(String tabel, String id, String customerId) async {
    final db = await DBHelper.database();
    db.delete(tabel,
        where: 'id = ? AND customerid = ?', whereArgs: [id, customerId]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getSpecificBusiness(
      String name) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT * FROM business WHERE name =?', [name]);
  }

  static Future<List<Map<String, dynamic>>> getAdvancePaymentForSpecifivPerson(
      String customerid) async {
    final db = await DBHelper.database();
    return db.rawQuery(
        'SELECT * FROM advancepayment WHERE customerid =?', [customerid]);
  }

  static Future<List<Map<String, dynamic>>> getFettilizerCostForSpecifivPerson(
      String customerid) async {
    final db = await DBHelper.database();
    return db.rawQuery(
        'SELECT * FROM purchesfertilizercost WHERE customerid =?',
        [customerid]);
  }

  static Future<List<Map<String, dynamic>>> getSuppliedKilosForSpecifivPerson(
      String customerid) async {
    final db = await DBHelper.database();
    return db.rawQuery(
        'SELECT * FROM supplykillo WHERE customerid =?', [customerid]);
  }
}
