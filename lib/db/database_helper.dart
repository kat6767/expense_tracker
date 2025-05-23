
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/gasto.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

// Función para poder obtener la tabla / leerla
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

// función para la inicialización (creación) de la tabla 
  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tabla_gastos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

// función onCreate para la creación de la tabla, contiene el query a ejecutar
  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tabla_gastos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoria TEXT,
        monto REAL,
        fecha TEXT,
        descripcion TEXT
      )
    ''');
  }

// función para insertar gastos
  Future<int> insertarGastoDB(Gasto gasto) async {
    final db = await database;
    return await db.insert(
      'tabla_gastos', 
      gasto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      );
  }

// función para leer todos los gastos de la tabla 
  Future<List<Gasto>> obtenerGastosDB() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tabla_gastos');
    return List.generate(maps.length, (i) => Gasto.fromMap(maps[i]));
  }

// función para eliminar un gasto por medio de la id 
  Future<int> eliminarGastoDB(int id) async {
    final db = await database;
    return await db.delete('tabla_gastos', where: 'id = ?', whereArgs: [id]);
  }

// función actualizar gastos para modificar gastos dentro de la bd
  Future<int> actualizarGastoDB(Gasto gasto) async {
    final db = await database;
    return await db.update(
      'tabla_gastos',
      gasto.toMap(),
      where: 'id = ?',
      whereArgs: [gasto.id],
    );
  }

  // Función de carga de categorías
  static Future<List<String>> obtenerCategorias() async{
    final db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT DISTINCT categoria FROM tabla_gastos WHERE categoria IS NOT NULL'
    );

    return result.map((fila) => fila['categoria'] as String).toList();
  }

  // Función para borrar datos de prueba durante el desarrollo. 
  ///
  ///NOTA AL DESARROLLADOR: ELIMINAR FUNCIÓN AL COMPLETAR LA APP
  ///
  Future<void> borrarTodosLosGastos() async {
  final db = await database;
  await db.delete('tabla_gastos');
}

//elimina el archivo completamente
Future<void> eliminarBaseDeDatos() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'tabla_gastos.db');

  // Cierra la base de datos si está abierta
  if (_database != null) {
    await _database!.close();
    _database = null;
  }

  // Elimina el archivo de la base de datos
  final dbFile = File(path);
  if (await dbFile.exists()) {
    await dbFile.delete();
  }
}
}


