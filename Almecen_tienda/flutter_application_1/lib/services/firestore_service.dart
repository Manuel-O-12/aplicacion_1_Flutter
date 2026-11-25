import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/producto_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collection = 'productos';

  /// Stream en tiempo real de la colección "productos".
  Stream<List<Producto>> getProductos() {
    return _db.collection(_collection).snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Producto.fromFirestore(doc)).toList(),
        );
  }

  /// Agrega un nuevo producto a Firestore.
  Future<void> agregarProducto(Producto p) async {
    await _db.collection(_collection).add(p.toMap());
  }

  /// Actualiza un producto existente en Firestore.
  Future<void> actualizarProducto(Producto p) async {
    await _db.collection(_collection).doc(p.id).update(p.toMap());
  }

  /// Elimina un producto de Firestore por su id.
  Future<void> eliminarProducto(String id) async {
    await _db.collection(_collection).doc(id).delete();
  }

  /// Registra una venta: descuenta del stock y suma a cantidadVendida
  /// usando una transacción atómica en Firestore.
  Future<void> registrarVenta(String productoId, int cantidadVendida) async {
    final docRef = _db.collection(_collection).doc(productoId);

    await _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        throw Exception('El producto no existe.');
      }

      final stockActual = (snapshot.data()!['cantidad'] as num).toInt();
      final vendidoActual =
          (snapshot.data()!['cantidadVendida'] as num?)?.toInt() ?? 0;

      if (cantidadVendida > stockActual) {
        throw Exception(
            'Stock insuficiente. Disponible: $stockActual unidades.');
      }

      transaction.update(docRef, {
        'cantidad': stockActual - cantidadVendida,
        'cantidadVendida': vendidoActual + cantidadVendida,
      });
    });
  }
}
