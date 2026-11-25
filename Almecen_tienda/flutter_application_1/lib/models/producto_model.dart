import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  final String id;
  final String nombre;
  final double precioCompra;
  final double precioVenta;
  final int cantidad;
  final int cantidadVendida;
  final String? barcode;
  final String categoria;

  Producto({
    required this.id,
    required this.nombre,
    required this.precioCompra,
    required this.precioVenta,
    required this.cantidad,
    this.cantidadVendida = 0,
    this.barcode,
    required this.categoria,
  });

  factory Producto.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Producto(
      id: doc.id,
      nombre: data['nombre'] ?? '',
      precioCompra: (data['precioCompra'] as num?)?.toDouble() ?? 0.0,
      precioVenta: (data['precioVenta'] as num?)?.toDouble() ?? 0.0,
      cantidad: (data['cantidad'] as num?)?.toInt() ?? 0,
      cantidadVendida: (data['cantidadVendida'] as num?)?.toInt() ?? 0,
      barcode: data['barcode'] as String?,
      categoria: data['categoria'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'precioCompra': precioCompra,
      'precioVenta': precioVenta,
      'cantidad': cantidad,
      'cantidadVendida': cantidadVendida,
      'barcode': barcode,
      'categoria': categoria,
    };
  }

  Producto copyWith({
    String? id,
    String? nombre,
    double? precioCompra,
    double? precioVenta,
    int? cantidad,
    int? cantidadVendida,
    String? barcode,
    String? categoria,
  }) {
    return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      precioCompra: precioCompra ?? this.precioCompra,
      precioVenta: precioVenta ?? this.precioVenta,
      cantidad: cantidad ?? this.cantidad,
      cantidadVendida: cantidadVendida ?? this.cantidadVendida,
      barcode: barcode ?? this.barcode,
      categoria: categoria ?? this.categoria,
    );
  }
}
