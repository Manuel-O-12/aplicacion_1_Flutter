import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/inventario_provider.dart';
import 'package:flutter_application_1/routes/app_routes.dart';
import 'package:flutter_application_1/widgets/producto_card.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventarioProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Registro de ventas',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.ventas);
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                'Error: ${provider.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (provider.productos.isEmpty) {
            return const Center(
              child: Text(
                'No hay productos registrados.\nPresiona + para agregar uno.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: provider.productos.length,
            itemBuilder: (context, index) {
              final producto = provider.productos[index];
              return ProductoCard(producto: producto);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        tooltip: 'Agregar producto',
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.form);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
