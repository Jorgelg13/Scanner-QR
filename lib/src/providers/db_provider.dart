import 'dart:io';

import 'package:path/path.dart';
import 'package:scannerqr/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
export 'package:path_provider/path_provider.dart';

class DBProvider{

 static Database _database;
 static final DBProvider db = DBProvider._();

 DBProvider._();

Future<Database> get database async{
   if(_database != null) return _database;

   _database = await initDB();

   return _database;
 }

 initDB() async{
   Directory documentsDirectory = await getApplicationDocumentsDirectory();
   final path = join( documentsDirectory.path, 'ScansDB.db');

   return await openDatabase(
     path,
     version: 1,
     onOpen: (db){},
     onCreate: ( Database db, int version) async{
       await db.execute(
         'CREATE TABLE scans(' 
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
         ')'
       );
     }
   );
 }

//insertar registros
nuevoScanRaw(ScanModel registro) async{
  final db = await database;
  final res = await db.rawInsert(
    "INSERT INTO scans (id, tipo,valor) "
    "VALUES (${registro.id},'${registro.tipo}','${registro.valor}')"
  );

  return res;
}

insertarScan(ScanModel registro) async{
  final db = await database;
  final res = await db.insert('scans', registro.toJson());
  return res;
}

//obtener la informacion
Future<ScanModel> getScanId(int id) async{
  final db = await database;
  final res = await db.query('scans', where: 'id = ?',whereArgs: [id]);
  return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
}

//Regresar todos los registros
Future<List<ScanModel>> getTodos() async{
  final db = await database;
  final res = await db.query('scans' );
  List<ScanModel> listaRegistros = res.isNotEmpty 
                  ? res.map((reg) => ScanModel.fromJson(reg)).toList()
                  :[];
  return listaRegistros;
}

//Regresar todos los registros por tipo
Future<List<ScanModel>> getPorTipo(String tipo) async{
  final db = await database;
  final res = await db.rawQuery("SELECT * FROM scans where tipo = '$tipo'");
  List<ScanModel> listaRegistros = res.isNotEmpty 
                  ? res.map((reg) => ScanModel.fromJson(reg)).toList()
                  :[];
  return listaRegistros;
}


//actualizar registros
Future<int> updateScan(ScanModel registro) async{
  final db = await database;
  final res = await db.update('scans',registro.toJson(), where: 'id = ?', whereArgs: [registro.id]);
  return res;
}

//borrar registros
Future<int> deleteRegistro(int id) async{
  final db = await database;
  final res = await db.rawDelete("DELETE FROM scans where id = $id");
  return res;
}

//borrar todos
Future<int> deleteAll() async{
  final db = await database;
  final res = await db.rawDelete("DELETE FROM scans");
  return res;
}


}