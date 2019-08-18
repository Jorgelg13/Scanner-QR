import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:scannerqr/src/block/scans_bloc.dart';
import 'package:scannerqr/src/models/scan_model.dart';
import 'package:scannerqr/src/utils/utils.dart';

class DireccionesPage extends StatelessWidget {
    final scanBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scanBloc.listar();
    return StreamBuilder<List<ScanModel>>(
      stream: scanBloc.scanStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        
        if (!snapshot.hasData) {
          return (Center(child: CircularProgressIndicator()));
        }

        final scans = snapshot.data;

        if (scans.length == 0) {
          return Center(
            child: Text(
              'No Hay informacion almacenada',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          );
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direccion){
                  scanBloc.borrar(scans[i].id);
                },
                child: ListTile(
                  onTap: (){
                    abrirScan(context,scans[i]);
                  },
                  leading: Icon(
                    Icons.cloud,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(scans[i].valor),
                  subtitle: Text('ID:' + scans[i].id.toString()),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                ),
              ),
        );
      },
    );
  }
}
