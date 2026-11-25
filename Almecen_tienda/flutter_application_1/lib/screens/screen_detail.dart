import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/models/producto_model.dart';
import 'package:flutter_application_1/providers/inventario_provider.dart';
import 'package:flutter_application_1/routes/app_routes.dart';

class ScreenDetail extends StatelessWidget {
  const ScreenDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final producto =
        ModalRoute.of(context)!.settings.arguments as Producto;
    final provider = context.read<InventarioProvider>();
    final bool stockBajo = producto.cantidad < 5;

    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow(label: 'Nombre', value: producto.nombre),
            _InfoRow(label: 'Categoría', value: producto.categoria),
            _InfoRow(
              label: 'Precio de compra',
              value: '\$${producto.precioCompra.toStringAsFixed(2)}',
            ),
            _InfoRow(
              label: 'Precio de venta',
              value: '\$${producto.precioVenta.toStringAsFixed(2)}',
            ),
            _InfoRow(
              label: 'Stock actual',
              value: '${producto.cantidad} unidades',
              valueColor: stockBajo ? Colors.red : null,
            ),
            if (stockBajo)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Stock bajo — menos de 5 unidades',
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ],
                ),
              ),
            _InfoRow(
              label: 'Cantidad vendida',
              value: '${producto.cantidadVendida} unidades',
            ),
            if (producto.barcode != null && producto.barcode!.isNotEmpty)
              _InfoRow(label: 'Código de barras', value: producto.barcode!),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar Producto'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      side: const BorderSide(color: Colors.blueAccent),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.form,
                        arguments: producto,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.sell),
                    label: const Text('Registrar Venta'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () =>
                        _mostrarDialogoVenta(context, producto, provider),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoVenta(
    BuildContext context,
    Producto producto,
    InventarioProvider provider,
  ) {
    final TextEditingController cantidadController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registrar Venta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Producto: ${producto.nombre}'),
            Text('Stock disponible: ${producto.cantidad}'),
            const SizedBox(height: 16),
            TextField(
              controller: cantidadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cantidad a vender',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final int? cantidad =
                  int.tryParse(cantidadController.text.trim());
              if (cantidad == null || cantidad <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Ingresa una cantidad válida.')),
                );
                return;
              }
              Navigator.pop(ctx);
              try {
                await provider.registrarVenta(producto.id, cantidad);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Venta de $cantidad unidades registrada.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context); // Regresar a Home
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
