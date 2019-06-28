import 'dart:async';
import 'package:scannerqr/src/models/scan_model.dart';
import 'package:scannerqr/src/providers/db_provider.dart';

class ScansBloc{
  static final ScansBloc _singleton= new ScansBloc._internal();

  //sirve para retornar una unica instancia de la clase
  //cuando se cree una instancia este regresara la variable _singleton
  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //obtener los scans de la base de datos
    listar();
  }

  //el brodcast sirve para referir que en varios lugares se estara escuchando
  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream <List<ScanModel>> get scanStream => _scansController.stream;

  dispose(){
    _scansController?.close();
  }

  listar() async{
    _scansController.sink.add(await DBProvider.db.getTodos() );
  }  

  agregar(ScanModel registro) async{
    await DBProvider.db.insertarScan(registro);
    listar();
  }

  borrar(int id) async{
    await DBProvider.db.deleteRegistro(id);
    listar();
  }

  borrarTodos() async{
    await DBProvider.db.deleteAll();
    listar();
  }
}