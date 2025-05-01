import 'package:expense_tracker/db/database_helper.dart';
import 'package:expense_tracker/models/gasto.dart';
import 'package:flutter/material.dart';
import '/screens/add_gasto.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Gasto>> _futureGastos;

//actualización continua de los datos mostrados en pantalla
  @override
  void initState() {
    super.initState();
    _cargarGastos();
  }

// Función de obtención de datos de la db
  void _cargarGastos() {
    _futureGastos = DatabaseHelper().obtenerGastosDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gastos personales")),
      // Lógica del widget
      body: FutureBuilder<List<Gasto>>(
        future: _futureGastos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));

          final gastos = snapshot.data ?? [];

          if (gastos.isEmpty)
            return Center(child: Text("No hay gastos registrados."));


          //columna que contiene la lista de datos y espacio para otros botones o elementos
          return Column( 
            children:
           [
              ElevatedButton(onPressed: () async {
                // Llamar al método para borrar todos los gastos
                 await DatabaseHelper().borrarTodosLosGastos();

                 // Volver a cargar los datos de la base de datos
                  setState(() {
                  _cargarGastos();
                 });
                },
  child: Text("Borrar datos de la bd (PRUEBAS)"),),
            Expanded(
              child: 
                ListView.builder(
               itemCount: gastos.length,
                 itemBuilder: (context, index) {
                    final gasto = gastos[index];
                    return ListTile(
                      title: Text(gasto.categoria),
                      subtitle: Text("Monto: \$${gasto.monto.toStringAsFixed(2)} \nDescripción: ${gasto.descripcion} \nFecha: ${gasto.fecha}"),
                        );
                      },
                   ), 
              )
           ]);
        },
      ),

    // Botón agregar gasto
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AgregarGastoPage()),
          );
          setState(() {
            _cargarGastos(); // ← vuelve a cargar los datos cuando regresas
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
