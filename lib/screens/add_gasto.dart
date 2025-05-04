import 'package:flutter/material.dart';
import '/db/database_helper.dart';
import '/models/gasto.dart';

class AgregarGastoPage extends StatefulWidget {
  @override
  _AgregarGastoPageState createState() => _AgregarGastoPageState();
}

// Estado de la pantalla agregar Gasto: Lógica e interacción con la base de datos
class _AgregarGastoPageState extends State<AgregarGastoPage> {
  final _formKey = GlobalKey<FormState>();
  final _categoriaController = TextEditingController();
  final _montoController = TextEditingController();
  final _fechaController = TextEditingController();
  final _descripcionController = TextEditingController();

  // destrucción de los controladores del form luego de su uso
  @override
  void dispose() {
    _categoriaController.dispose();
    _montoController.dispose();
    _fechaController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  // función con la que se obtienen los datos ingresados y se guardan en la base de datos.
  Future<void> _guardarGasto() async {
    if (_formKey.currentState!.validate()) {
      final categoriaIngresada = _categoriaController.text;
      final montIngresado = double.tryParse(_montoController.text) ?? 0.0;
      final fechaIngresada = _fechaController.text;
      final descripcionIngresada = _descripcionController.text;

      // Creación de objeto gasto para ingresarse a la bd
      final gastoIngresado = Gasto(
        categoria: categoriaIngresada,
        monto: montIngresado,
        fecha: fechaIngresada,
        descripcion: descripcionIngresada,
      );
      await DatabaseHelper().insertarGastoDB(
        gastoIngresado,
      ); // adición de los datos a la bd

      Navigator.pop(context); // Regresa a la pantalla anterior
    }
  }

  // Construcción de la pantalla.
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidht = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(232, 237, 234, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(
            241,
            255,
            243,
            1,
          ), // Cambia a cualquier color que quieras
        ),
        centerTitle: true,
        toolbarHeight: 0.10 * screenHeight,
        backgroundColor: Color.fromRGBO(232, 237, 234, 1),
        title: Text(
          'Agregar Gasto',
          style: TextStyle(
            color: Color.fromRGBO(9, 48, 48, 1),
            fontWeight: FontWeight.bold,
            fontSize: 19
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(241, 255, 243, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(55),
              topRight: Radius.circular(55),
            ),
          ),
          height: 0.9 * screenHeight,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //Elemento de Fecha
              children: [
                Padding(//Primer elemento
                  padding: EdgeInsets.fromLTRB(35, 60,35, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: Text(
                          'Fecha',
                          style: TextStyle(
                            color: Color.fromRGBO(9, 48, 48, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          
                          //labelText: 'Ingresar Fecha',
                          //labelStyle: TextStyle(color: Color.fromRGBO(123, 150, 148, 1)),
                          hintText: 'Ingresar Fecha',
                          filled: true,
                          fillColor: Color.fromRGBO(232, 237, 234, 1),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Color.fromRGBO(9, 48, 48, 1)),
                        controller: _fechaController,
                        validator:(value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa la fecha'
                              : null, 
                      ),
                    ],
                  ),
                ),

                //Elemento de Categoria
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: Text(
                          'Categoria',
                          style: TextStyle(
                            color: Color.fromRGBO(9, 48, 48, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          
                          //labelText: 'Ingresar Fecha',
                          //labelStyle: TextStyle(color: Color.fromRGBO(123, 150, 148, 1)),
                          hintText: 'Ingresar categoria',
                          filled: true,
                          fillColor: Color.fromRGBO(232, 237, 234, 1),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Color.fromRGBO(9, 48, 48, 1)),
                        controller: _categoriaController,
                        validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa una categoría'
                              : null,
                      ),
                      
                    ],
                  ),
                ),
                //Elemento Monto
                      Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: Text(
                          'Monto',
                          style: TextStyle(
                            color: Color.fromRGBO(9, 48, 48, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          
                          //labelText: 'Ingresar Fecha',
                          //labelStyle: TextStyle(color: Color.fromRGBO(123, 150, 148, 1)),
                          hintText: 'Insertar Monto',
                          filled: true,
                          fillColor: Color.fromRGBO(232, 237, 234, 1),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Color.fromRGBO(9, 48, 48, 1)),
                        controller: _montoController,
                        validator:(value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa un monto válido'
                              : null,
                      ),
                      //Elemento Descripcion
                      
                    ],
                  ),
                ),
                //Elemento DESCRIPCION
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: Text(
                          'Descripción',
                          style: TextStyle(
                            color: Color.fromRGBO(9, 48, 48, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          
                          //labelText: 'Ingresar Fecha',
                          //labelStyle: TextStyle(color: Color.fromRGBO(123, 150, 148, 1)),
                          hintText: 'Ingrese una descripción',
                          filled: true,
                          fillColor: Color.fromRGBO(232, 237, 234, 1),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Color.fromRGBO(9, 48, 48, 1)),
                        controller: _descripcionController,
                        validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa una descripción'
                              : null,
                      ),
                    ],
                  ),
                ),
                
                /*
                //TextBox categoria
                TextFormField(
                  controller: _categoriaController,
                  decoration: InputDecoration(labelText: 'Categoria'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa una categoría'
                              : null,
                ),
                //espacio
                SizedBox(height: 20),

                //texbox monto
                TextFormField(
                  controller: _montoController,
                  decoration: InputDecoration(labelText: 'Monto'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa un monto válido'
                              : null,
                ),
                SizedBox(height: 20),

                //textbox fecha
                /*TextFormField(
                  controller: _fechaController,
                  decoration: InputDecoration(labelText: 'Fecha DD, MM, AA'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa la fecha'
                              : null,
                ),*/
                SizedBox(height: 20),

                TextFormField(
                  controller: _descripcionController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingresa una descripción'
                              : null,
                ),*/
                

                //Botón guardarGasto
                Padding(padding: EdgeInsets.fromLTRB(0,30,0,60),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(2, 48, 36,1),
                    elevation: 0


                  ),
                  onPressed: _guardarGasto,
                  child: Text('Guardar gasto', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1) ),),
                ),
                
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
