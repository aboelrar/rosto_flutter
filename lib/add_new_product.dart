import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class add_new_product {
  String table = 'product';
  static Database _db;

  Future<Database> get db async{
    if(_db == null){
      _db = await initialDB();
      return _db;
    }else{
      return _db;
    }
  }

  initialDB() async{
    io.Directory docDirect = await getApplicationDocumentsDirectory();
    String path = join(docDirect.path,'testdb.db');
    var mydb = await openDatabase(path,version: 1,onCreate: (Database db,int version) async{
      await db.execute("CREATE TABLE ${table}(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,description TEXT,size TEXT,quantity TEXT,product_id TEXT,price TEXT,size_id TEXT)");

      print('Notes Table Created');
    });
    return mydb;
  }

  Future<int> create(Map<String,dynamic> data) async{
    var dbclient = await db;
    int insert = await dbclient.insert(table, data);
    //await dbclient.close();
    return insert;
  }

  Future<List> getData() async{
    var db_products =await db;
    return await db_products.query(table);
  }

  //DELETE
  Future<int> delete(int id) async{
    var dbclient = await db;
    int delete = await dbclient.rawUpdate('DELETE FROM $table where id ="$id" ');
    return delete;
  }

  Future<int> deleteAll() async{
    var dbclient = await db;
    int delete = await dbclient.delete(table);
    return delete;
  }



}