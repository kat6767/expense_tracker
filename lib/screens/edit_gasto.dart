import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/db/database_helper.dart';
import '/models/gasto.dart';

class EditarGastoPage extends StatefulWidget {
  final Gasto gasto; // definimos que se necesita esta información guardada en esa variable para crear el widget

  const EditarGastoPage({super.key, required this.gasto}); //builder donde se requiere dicha info

  @override
  _EditarGastoPageState createState() => _EditarGastoPageState();
  
}

// Estado de la pantalla agregar Gasto: Lógica e interacción con la base de datos
class _EditarGastoPageState extends State<EditarGastoPage> {
  final _formKey = GlobalKey<FormState>();
  final _categoriaController = TextEditingController();
  final _montoController = TextEditingController();
  final _fechaController = TextEditingController();
  final _descripcionController = TextEditingController();

  // Función para obtener la fecha con un datePicker (calendario )
   Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (fechaSeleccionada != null) {
    setState(() {
      _fechaController.text =
          '${fechaSeleccionada.day.toString().padLeft(2, '0')}/${fechaSeleccionada.month.toString().padLeft(2, '0')}/${fechaSeleccionada.year}';
    });
  }
  
   }

  @override 
  void initState() {
    super.initState();
    _categoriaController.text = widget.gasto.categoria;
    _montoController.text = widget.gasto.monto.toString();
    _fechaController.text = widget.gasto.fecha;
    _descripcionController.text = widget.gasto.descripcion;
  }

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
      final montoIngresado = double.tryParse(_montoController.text) ?? 0.0;
      final fechaIngresada = _fechaController.text;
      final descripcionIngresada = _descripcionController.text;

      // Creación de objeto gasto para ingresarse a la bd
      final gastoActualizado = Gasto(
        id: widget.gasto.id,
        categoria: categoriaIngresada,
        monto: montoIngresado,
        fecha: fechaIngresada,
        descripcion: descripcionIngresada,
      );

      await DatabaseHelper().actualizarGastoDB(
        gastoActualizado,
      ); // actualización de los datos a la bd

      Navigator.pop(context); // Regresa a la pantalla anterior
    }
  }

  // Construcción de la pantalla.
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
          'Editar Gasto',
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

          //Formulario para ingresar gasto
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //Elemento de Fecha
                children: [
                  Padding(//Primer elemento

                    padding: EdgeInsets.fromLTRB(0.08*screenWidth, 0.07*screenHeight,0.08*screenWidth, 0),
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
                            suffixIcon: Icon(Icons.calendar_today),
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
                          readOnly: true,
                          onTap: () => _seleccionarFecha(context),
                          validator:(value) {
                               if (value == null || value.isEmpty){
                                 return 'Por favor selecciona una fecha';   
                            }
                            return null;
                          }
            
                    
                        ),
                      ],
                    ),
                  ),
            
                  //Elemento de Categoria
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.08*screenWidth,0.03*screenHeight, 0.08*screenWidth, 0),
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
                    padding: EdgeInsets.fromLTRB(0.08*screenWidth, 0.03*screenHeight, 0.08*screenWidth, 0),
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
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                          ],
                          validator:(value) {
                            if (value == null || value.trim().isEmpty) {
                                return 'Ingresa un monto válido';
                              }
                              final parsed = double.tryParse(value); 
                              if (parsed == null){
                                return 'Debe ser un número decimal';
                              }
                              return null;
                          }
                        ),


                        //Elemento Descripcion
                      ],
                    ),
                  ),
                  //Elemento DESCRIPCION
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.08*screenWidth, 0.03*screenHeight, 0.08*screenWidth, 0),
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
                  Padding(padding: EdgeInsets.fromLTRB(0,0.1*screenHeight,0,0),
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
            )
          ),
          ) 
        ),
      );
  }
}