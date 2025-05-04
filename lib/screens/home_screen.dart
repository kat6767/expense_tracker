/*import 'package:expense_tracker/db/database_helper.dart';
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
*/

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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidht = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(232, 237, 234, 1),
      //appBar: AppBar(title: Text("Gastos personales")),
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
            children: [
              /*ElevatedButton(onPressed: () async {
                // Llamar al método para borrar todos los gastos
                 await DatabaseHelper().borrarTodosLosGastos();

                 // Volver a cargar los datos de la base de datos
                  setState(() {
                  _cargarGastos();
                 });
                },
  child: Text("Borrar datos de la bd (PRUEBAS)"),),*/
              Container(
                //primer contendor con aproxx 30% de la altura de la pantalla
                height: screenHeight * 0.308,

                child: Column(
                  //Columna para dividir el primer contendor en 2
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      //Texto de bienvenida
                      height: 0.10 * screenHeight,
                      color: Color.fromRGBO(232, 237, 234, 1),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(35, 50, 0, 0),
                        child: Text(
                          'Bienvenido',
                          style: TextStyle(
                            color: Color.fromRGBO(5, 34, 36, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      //segundo contenedor aislado
                      height: 0.208 * screenHeight,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 0.16 * screenHeight,
                            width: 0.85 * screenWidht,

                            decoration: BoxDecoration(
                              color: Color.fromRGBO(2, 48, 36, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              //fila para logo y Gastos Totales
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  //contendor para el logo
                                  width: 0.25 * screenWidht,
                                  child: const Center(
                                    child: Icon(
                                      Icons.show_chart,
                                      color: Colors.greenAccent,
                                      size: 60,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  color: Color.fromRGBO(241, 255, 243, 1),
                                  thickness: 2,
                                  indent: 0.018 * screenHeight,
                                  endIndent: 0.018 * screenHeight,
                                  width: 0.02 * screenWidht,
                                ),

                                Container(
                                  width: 0.58 * screenWidht,
                                  child: Column(
                                    //colimna para
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Gastos Totales',
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                            242,
                                            247,
                                            248,
                                            1,
                                          ),
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Text(
                                        r'-$1,1500.00',
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                            242,
                                            247,
                                            248,
                                            1,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ), //esta sera una variable lol creo
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //final del primer contenedor
              ),

              Container(
                // segundo contenedor con aprox el 70% de la altura de la pantalla
                height: screenHeight * 0.692,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(241, 255, 243, 1),
                  borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
                ),
                child: Column(
                  // para dividir segunda columna en 3
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //contendor de Fecha y Monto
                      height: 0.15 * screenHeight,
                      width: screenWidht,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            //contendor junior para padding manual
                            height: 0.07 * screenHeight,
                            width: 0.75 * screenWidht,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(232, 237, 234, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 0.07 * screenHeight,
                                  width: 0.5 * screenWidht,
                                  child: Column(
                                    //colimna para
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          20,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Text('Fecha'),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 0.07 * screenHeight,
                                  width: 0.25 * screenWidht,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(2, 48, 36, 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    //colimna para
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Monto',
                                        style: TextStyle(
                                          color: Color.fromRGBO(
                                            254,
                                            255,
                                            255,
                                            1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(height: 0.03 * screenHeight),
                        ],
                      ),
                    ),
                    Container(
                      // para la lista de gastos e ingresos
                      height: 0.45 * screenHeight,

                      //posicion de la lista
                      child: ListView.builder(
                        itemCount: gastos.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final gasto = gastos[index];
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 0,
                            ),
                            leading: Container(
                              //para el icono
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(2, 48, 36, 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 0.07 * screenHeight,
                              child: Icon(
                                Icons.show_chart,
                                color: Colors.greenAccent,
                                size: 0.07 * screenHeight,
                              ),
                            ),

                            title: Text(
                              gasto.categoria,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                            //\nDescripción: ${gasto.descripcion}   Codigo para acceder a descripcion
                            subtitle: Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                              ), // espaciado entre título y subtítulo
                              child: Text('${gasto.fecha}'),
                            ),

                            trailing: Text(
                              "-\$${gasto.monto.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      //para barra de opciones o boton de agregar
                      height: 0.092 * screenHeight,
                      width: screenWidht,
                      child: Column(
                        //el boton
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),

                            child:
                            /*
                        Container(
                          
                          



                          width: 0.08*screenHeight,
                          height: 0.05*screenHeight,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(2,48,36,1),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: const Color.fromARGB(255, 255, 255, 255), size: 0.04*screenHeight)
                            ],
                          ),
                          
                        ),*/
                            GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AgregarGastoPage(),
                                  ),
                                );
                                setState(() {
                                  _cargarGastos();
                                });
                              },
                              child: Container(
                                width: 0.08 * screenHeight,
                                height: 0.05 * screenHeight,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(2, 48, 36, 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 0.04 * screenHeight,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /*
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


*/
            ],
          );
        },
      ),

      // Botón agregar gasto
      /*floatingActionButton: FloatingActionButton(
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
      ),*/
    );
  }
}
//>>>>>>> Stashed changes
