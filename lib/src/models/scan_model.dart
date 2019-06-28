import 'package:latlong/latlong.dart';

class ScanModel {
    int id;
    String tipo;
    String valor;

    ScanModel({
        this.id,
        this.tipo,
        this.valor,
    }){
      if(this.valor.contains('http')){
        this.tipo = 'http';
      }
      else{
        this.tipo ='geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };

    getLatLong(){
      final coordenadas = valor.substring(4).split(',');
      final latitud = double.parse(coordenadas[0]);
      final longitud = double.parse(coordenadas[1]);

      return LatLng(latitud,longitud);
    }
}