import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/producto_model.dart';
import 'package:flutter_application_1/routes/app_routes.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;

  const ProductoCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final bool stockBajo = producto.cantidad < 5;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          producto.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categoría: ${producto.categoria}',
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              'Precio venta: \$${producto.precioVenta.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Stock',
              style: TextStyle(
                fontSize: 11,
                color: stockBajo ? Colors.red : Colors.grey,
              ),
            ),
            Text(
              '${producto.cantidad}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: stockBajo ? Colors.red : Colors.blueAccent,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.detail,
            arguments: producto,
          );
        },
      ),
    );
  }
}
