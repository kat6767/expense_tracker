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
    if (_formKey.currentState!.validate()){
      final categoriaIngresada = _categoriaController.text; 
      final montIngresado = double.tryParse(_montoController.text) ?? 0.0; 
      final fechaIngresada = _fechaController.text;
      final descripcionIngresada = _descripcionController.text; 

      // Creación de objeto gasto para ingresarse a la bd
      final gastoIngresado = Gasto(
        categoria: categoriaIngresada, 
        monto: montIngresado, 
        fecha: fechaIngresada, 
        descripcion: descripcionIngresada
        );
      await DatabaseHelper().insertarGastoDB(gastoIngresado); // adición de los datos a la bd

      Navigator.pop(context); // Regresa a la pantalla anterior
    }
  }

  // Construcción de la pantalla. 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Gasto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //TextBox categoria
              TextFormField(
                controller: _categoriaController,
                decoration: InputDecoration(labelText: 'Categoria'),
                validator: (value) => 
                      value == null || value.isEmpty ? 'Ingresa una categoría' : null,
              ),
                //espacio
              SizedBox(height: 20),

              //texbox monto
              TextFormField(
                controller: _montoController,
                decoration: InputDecoration(labelText: 'Monto'),
                validator: (value) => 
                      value == null || value.isEmpty ? 'Ingresa un monto válido' : null,
              ),
              SizedBox(height: 20), 

              //textbox fecha 
              TextFormField(
                controller: _fechaController,
                decoration: InputDecoration(labelText: 'Fecha DD, MM, AA'),
                validator: (value) => 
                      value == null || value.isEmpty ? 'Ingresa la fecha' : null,
              ),
              SizedBox(height: 20), 

              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) => 
                      value == null || value.isEmpty ? 'Ingresa una descripción' : null,
              ),
              SizedBox(height: 20),

              //Botón guardarGasto
              ElevatedButton(
                onPressed: _guardarGasto, 
                child: Text('Guardar gasto')
                ),
            ],
          )
          )
        )
      );
  }
  
}