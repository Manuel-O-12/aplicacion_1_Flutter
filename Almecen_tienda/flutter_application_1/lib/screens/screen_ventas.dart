import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/inventario_provider.dart';

class ScreenVentas extends StatelessWidget {
  const ScreenVentas({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventarioProvider>();
    final productos = provider.productos;

    // Calcular totales
    int totalUnidadesVendidas = 0;
    double gananciaTotal = 0.0;

    for (final p in productos) {
      totalUnidadesVendidas += p.cantidadVendida;
      gananciaTotal +=
          (p.precioVenta - p.precioCompra) * p.cantidadVendida;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Ventas'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: productos.isEmpty
                      ? const Center(
                          child: Text(
                            'No hay productos registrados.',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: productos.length,
                          itemBuilder: (context, index) {
                            final p = productos[index];
                            final ganancia =
                                (p.precioVenta - p.precioCompra) *
                                    p.cantidadVendida;
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                title: Text(
                                  p.nombre,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Unidades vendidas: ${p.cantidadVendida}',
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Ganancia',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.grey),
                                    ),
                                    Text(
                                      '\$${ganancia.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                // Totales
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade100.withAlpha(40),
                    border: const Border(
                      top: BorderSide(color: Colors.blueAccent, width: 1.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total unidades vendidas',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            '$totalUnidadesVendidas',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Ganancia total estimada',
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey),
                          ),
                          Text(
                            '\$${gananciaTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
