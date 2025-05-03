import 'package:expense_tracker/providers/gasto_providers.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GastosProvider()..cargarGastos(),  // Notificador global de cambios para los gastos y carga de la bd local
      child: MyApp(),
      ),
    );
}

//Cambio de prueba

// Base de la app 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(), // Uso de home_screen para pruebas
      debugShowCheckedModeBanner: false,
    );
  }
}
