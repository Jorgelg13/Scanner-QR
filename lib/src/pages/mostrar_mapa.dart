import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:scannerqr/src/models/scan_model.dart';

class MostrarMapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
            },
          )
        ],
      ),
      body: _mostrarMapa(scan)
    );
  }

 Widget _mostrarMapa(ScanModel scan) {
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLong(),
          zoom: 30
        ),
        layers: [
          _crearMapa(),
        ],
      );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJjanY2MjF4NGIwMG9nM3lvMnN3ZDM1dWE5In0.0SfmUpbW6UFj7ZnRdRyNAw',
        'id': 'mapbox.streets'
      }
    );
 }

}