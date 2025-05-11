import 'package:expense_tracker/db/database_helper.dart';
import 'package:expense_tracker/models/gasto.dart';
import 'package:expense_tracker/screens/edit_gasto.dart';
import 'package:flutter/material.dart';
import '/screens/add_gasto.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Gasto>> _futureGastos;
  Set<int> _expandedIndices = {};

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

          final sumaTotalGastos = gastos.fold<double>(
            0.0,
            (prev, gasto) => prev + gasto.monto,
          );

          //if (gastos.isEmpty)
          //return Center(child: Text("No hay gastos registrados."));

          //columna que contiene la lista de datos y espacio para otros botones o elementos
          return Column(
            children: [
              SizedBox(
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

                    /// ESPACIO PARA BOTONES DE PRUEBA AQUÍ ///
                    ///
                    SizedBox(
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
                                SizedBox(
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
                                SizedBox(
                                  width: 0.58 * screenWidht,

                                  // Columna para la caja de suma total de gastos y el listado de gastos
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Texto para la caja de suma total de gastos
                                      const Text(
                                        'Gastos Totales',
                                        style: TextStyle(
                                          color: Color.fromRGBO(242, 247, 248, 1,),
                                          fontSize: 12,
                                        ),
                                      ),

                                      //Texto para la suma total de datos
                                      Text(
                                        '${sumaTotalGastos.toString()}',
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  // para dividir segunda columna en 3
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
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
                                SizedBox(
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

                    SizedBox(
                      // para la lista de gastos e ingresos
                      height: 0.45 * screenHeight,

                      //posicion de la lista
                      child: ListView.builder(
                        itemCount: gastos.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final gasto = gastos[index];

                          /// LISTA DE GASTOS 
                          return Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 0,
                                ),
                                leading: Container(
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
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(gasto.fecha),
                                ),
                                trailing: Text(
                                  "-\$${gasto.monto.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),

                                /// DETECCIÓN DE GESTO "TAP" PARA EXPANDIR / COLAPSAR LA LISTA
                                onTap: () {
                                  setState(() {
                                    if (_expandedIndices.contains(index)) {
                                      _expandedIndices.remove(index);
                                    } else {
                                      _expandedIndices.add(index);
                                    }
                                  });
                                },

                                /// DETECCIÓN DE GESTO "LONGPRESS" PARA MOSTRAR OPCIONES DE ELIMINACIÓN/EDICIÓN DE GASTOS
                                onLongPress: () async {                            
                                  final result = await showDialog<String>(
                                    context: context,
                                    builder:
                                        (context) => SimpleDialog(
                                          title: Text('Acciones'),
                                          children: [
                                            SimpleDialogOption(
                                              child: Text('Editar'),
                                              onPressed:
                                                  () => Navigator.pop(
                                                    context,
                                                    'editar',
                                                  ),
                                            ),

                                            /// DIALOGO DE ELIMINACIÓN AL PRESIONAR LA OPCIÓN DE ELIMINAR
                                            SimpleDialogOption(
                                              child: Text('Eliminar'),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                final confirm = await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                        title: Text('Eliminar Gasto',),
                                                        content: Text('¿Estás seguro de que quieres eliminar este gasto?',),
                                                        actions: [
                                                          TextButton(
                                                            onPressed:() =>
                                                                    Navigator.pop(context, false,),
                                                            child: Text(
                                                              'Cancelar',
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>Navigator.pop(context, true, ),
                                                            child: Text(
                                                              'Eliminar',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                );

                                                if (confirm == true) {
                                                  await DatabaseHelper()
                                                      .eliminarGastoDB(
                                                        gasto.id!,
                                                      );
                                                  setState(() {
                                                    _cargarGastos();
                                                  });
                                                }
                                              },
                                            ),
                                            SimpleDialogOption(
                                              child: Text('Cancelar'),
                                              onPressed:
                                                  () => Navigator.pop(
                                                    context,
                                                    null,
                                                  ),
                                            ),
                                          ],
                                        ),
                                  );

                                  /// LÓGICA DE NAVEGACIÓN AL SELECCIONAR LA OPCIÓN "EDITAR"                        
                                  if (result == 'editar') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                EditarGastoPage(gasto: gasto),
                                      ),
                                    ).then((_) {
                                      setState(() {
                                        _cargarGastos();
                                      });
                                    });
                                  }
                                },
                              ),


                              /// LÓGICA DE EXPANSIÓN PARA MOSTRAR LA DESCRIPCIÓN
                              if (_expandedIndices.contains(index))
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0,
                                    vertical: 5,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Descripción: ${gasto.descripcion}",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),

                    /// BOTÓN PARA AGREGAR GASTOS 
                    SizedBox(
                      height: 0.092 * screenHeight,
                      width: screenWidht,
                      child: Column(
                        //el boton
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),

                            child: GestureDetector(
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
            ],
          );
        },
      ),
    );
  }
}
