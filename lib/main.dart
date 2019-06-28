import 'package:flutter/material.dart';
import 'package:scannerqr/src/pages/home.dart';
import 'package:scannerqr/src/pages/mostrar_mapa.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scanner QR',
       initialRoute: 'home',
       routes: {
         'home':(BuildContext context) => HomePage(),
         'mapa':(BuildContext context) => MostrarMapa(),
       },
       theme: ThemeData(
         primaryColor: Colors.deepPurple
       ),
    );
  }
}