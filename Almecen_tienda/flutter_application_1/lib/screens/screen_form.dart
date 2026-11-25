import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/producto_model.dart';
import 'package:flutter_application_1/providers/inventario_provider.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';

class ScreenForm extends StatefulWidget {
  const ScreenForm({super.key});

  @override
  State<ScreenForm> createState() => _ScreenFormState();
}

class _ScreenFormState extends State<ScreenForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nombreController;
  late final TextEditingController _precioCompraController;
  late final TextEditingController _precioVentaController;
  late final TextEditingController _cantidadController;
  late final TextEditingController _barcodeController;
  late final TextEditingController _categoriaController;

  Producto? _productoEditar;
  bool _modoEditar = false;
  bool _guardando = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Inicializar una sola vez
    if (!_modoEditar) {
      _productoEditar =
          ModalRoute.of(context)?.settings.arguments as Producto?;
      _modoEditar = _productoEditar != null;

      _nombreController =
          TextEditingController(text: _productoEditar?.nombre ?? '');
      _precioCompraController = TextEditingController(
        text: _productoEditar != null
            ? _productoEditar!.precioCompra.toString()
            : '',
      );
      _precioVentaController = TextEditingController(
        text: _productoEditar != null
            ? _productoEditar!.precioVenta.toString()
            : '',
      );
      _cantidadController = TextEditingController(
        text: _productoEditar != null
            ? _productoEditar!.cantidad.toString()
            : '',
      );
      _barcodeController =
          TextEditingController(text: _productoEditar?.barcode ?? '');
      _categoriaController =
          TextEditingController(text: _productoEditar?.categoria ?? '');
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _precioCompraController.dispose();
    _precioVentaController.dispose();
    _cantidadController.dispose();
    _barcodeController.dispose();
    _categoriaController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _guardando = true);

    final provider = context.read<InventarioProvider>();

    final nombre = _nombreController.text.trim();
    final precioCompra =
        double.tryParse(_precioCompraController.text.trim()) ?? 0.0;
    final precioVenta =
        double.tryParse(_precioVentaController.text.trim()) ?? 0.0;
    final cantidad = int.tryParse(_cantidadController.text.trim()) ?? 0;
    final barcode = _barcodeController.text.trim();
    final categoria = _categoriaController.text.trim();

    if (_modoEditar && _productoEditar != null) {
      final actualizado = _productoEditar!.copyWith(
        nombre: nombre,
        precioCompra: precioCompra,
        precioVenta: precioVenta,
        cantidad: cantidad,
        barcode: barcode.isEmpty ? null : barcode,
        categoria: categoria,
      );
      await provider.actualizarProducto(actualizado);
    } else {
      final nuevo = Producto(
        id: '',
        nombre: nombre,
        precioCompra: precioCompra,
        precioVenta: precioVenta,
        cantidad: cantidad,
        cantidadVendida: 0,
        barcode: barcode.isEmpty ? null : barcode,
        categoria: categoria,
      );
      await provider.agregarProducto(nuevo);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modoEditar ? 'Editar Producto' : 'Agregar Producto'),
        backgroundColor:  Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Nombre',
                controller: _nombreController,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Ingresa el nombre' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Categoría',
                controller: _categoriaController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Precio de compra',
                controller: _precioCompraController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Ingresa el precio de compra' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Precio de venta',
                controller: _precioVentaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Ingresa el precio de venta' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Cantidad en stock',
                controller: _cantidadController,
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Ingresa la cantidad' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Código de barras (opcional)',
                controller: _barcodeController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _guardando ? null : _guardar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _guardando
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Guardar',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
