import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/producto_model.dart';
import 'package:flutter_application_1/services/firestore_service.dart';

class InventarioProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();

  List<Producto> _productos = [];
  bool _isLoading = true;
  String? _error;
  StreamSubscription<List<Producto>>? _subscription;

  List<Producto> get productos => _productos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  InventarioProvider() {
    _suscribirStream();
  }

  void _suscribirStream() {
    _isLoading = true;
    _subscription = _service.getProductos().listen(
      (lista) {
        _productos = lista;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> agregarProducto(Producto p) async {
    try {
      await _service.agregarProducto(p);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> actualizarProducto(Producto p) async {
    try {
      await _service.actualizarProducto(p);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> eliminarProducto(String id) async {
    try {
      await _service.eliminarProducto(id);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> registrarVenta(String productoId, int cantidadVendida) async {
    try {
      await _service.registrarVenta(productoId, cantidadVendida);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
