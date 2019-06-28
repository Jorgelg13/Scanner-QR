import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scannerqr/src/block/scans_bloc.dart';
import 'package:scannerqr/src/models/scan_model.dart';
import 'package:scannerqr/src/pages/direcciones.dart';
import 'package:scannerqr/src/pages/mapas.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:scannerqr/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scanBloc = new ScansBloc();
  int currentIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaner QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              scanBloc.borrarTodos();
            },
          )
        ],
      ),
      body: _llamarPagina(currentIndex),
      bottomNavigationBar: _botomNavigator(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed:() => _scannQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scannQR( BuildContext context) async{
    String futureString = 'https://reclamosgt.unitypromotores.com';

   /* try{
       futureString = await new QRCodeReader().scan();
    }catch(e){
      futureString = e.toString();
    }

     print('futurestring: $futureString');

    if(futureString != null){
      print('Tenemos Informacion');
    }*/

     if(futureString != null){
       final registro = ScanModel(valor: futureString);
       scanBloc.agregar(registro); 

        final registro2 = ScanModel(valor: 'geo:40.78923438432,-732434893438');
       scanBloc.agregar(registro2);

       if(Platform.isIOS){
          Future.delayed(Duration(milliseconds: 750),(){
            utils.abrirScan(context,registro);
          });
       }else{
         utils.abrirScan(context,registro);
       }
    }
  }

  Widget _llamarPagina(int paginaActual){
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default: 
      return MapasPage();
    }
  }

  Widget _botomNavigator() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),
      ],
    );
  }
}