import 'package:flutter/material.dart';
import '/models/gasto.dart';
import '/db/database_helper.dart';

// Notificador de gastos para las pantallas 
class GastosProvider with ChangeNotifier {
  List<Gasto> _gastos = [];  // lista con los gastos agregados (global)
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Gasto> get gastos => _gastos;  //getter para que las pantallas puedan leer dichos gastos 

  // función que recorre la lista y devuelve el total (como un for loop)
  double get totalGastos {
    return _gastos.fold(0.0, (suma, item) => suma + item.monto);
  }

  Future<void> cargarGastos() async{
    _gastos = await _dbHelper.obtenerGastosDB();
    notifyListeners();  // Notifica a todas las pantallas que se ha modificado agregado un nuevo gasto p/ q se actualicen
  }

  // función para agregar un gasto a la lista global y avisa a todas las pantallas del cambio (actualizacion automática)
  Future<void> agregarGasto(Gasto gasto) async {
    _gastos.add(gasto);
    notifyListeners(); // Notifica a todas las pantallas que se ha agregado un nuevo gasto p/ q se actualicen
  }

  Future<void> eliminarGasto(int id) async {
    await _dbHelper.eliminarGastoDB(id);
    await cargarGastos(); 
  }

  Future<void> actualizarGasto(Gasto gasto) async {
    await _dbHelper.actualizarGastoDB(gasto);
    await cargarGastos();
  }


}