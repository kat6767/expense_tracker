class Gasto {
  final String categoria;
  final double monto;
  final DateTime fecha;
  final String descripcion;

  Gasto({
    required this.categoria,
    required this.monto,
    required this.fecha,
    required this.descripcion,
  });
}