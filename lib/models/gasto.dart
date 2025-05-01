// Clase de diseño básico del objeto "Gasto"

class Gasto {
  final int? id;
  final String categoria;
  final double monto;
  final String fecha;
  final String descripcion;

  Gasto({
    this.id,
    required this.categoria,
    required this.monto,
    required this.fecha,
    required this.descripcion,
  });

  //conversión de objeto Gasto a objeto Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'categoria': categoria, 
      'monto': monto, 
      'fecha': fecha, 
      'descripcion': descripcion,
    };
  }



  // Conversión de objeto Map a objeto Gasto
  factory Gasto.fromMap(Map<String, dynamic> map){
    return Gasto(
      id: map['id'], 
      categoria: map['categoria'], 
      monto: map['monto'], 
      fecha: map['fecha'], 
      descripcion: map['descripcion'], 
     );
  }
}

