import 'package:flutter/material.dart';
import '/models/gasto.dart';

// Notificador de gastos para las pantallas 
class GastosProvider with ChangeNotifier {
  final List<Gasto> _gastos = [];  // lista con los gastos agregados (global)

  List<Gasto> get gastos => _gastos;  //getter para que las pantallas puedan leer dichos gastos 

  // función que recorre la lista y devuelve el total (como un for loop)
  double get totalGastos {
    return _gastos.fold(0.0, (suma, item) => suma + item.monto);
  }

  // función para agregar un gasto a la lsita global y avisa a todas las pantallas del cambio (actualizacion automática)
  void agregarGasto(Gasto gasto) {
    _gastos.add(gasto);
    notifyListeners(); // Notifica a todas las pantallas
  }
}