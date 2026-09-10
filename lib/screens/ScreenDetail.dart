import 'package:flutter/material.dart';

class PantallaDetalle extends StatelessWidget {
  final Map<String, dynamic> producto;

  const PantallaDetalle({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(producto["icono"], size: 120, color: Colors.blueAccent),
            const SizedBox(height: 24),
            Text(
              producto["nombre"],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 40, thickness: 2),
            
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Precio al público:', style: TextStyle(fontSize: 18)),
                        Text(producto["precio"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Unidades en stock:', style: TextStyle(fontSize: 18)),
                        Text(
                          '${producto["stock"]}', 
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                            color: producto["stock"] < 10 ? Colors.red : Colors.black
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  
                },
                icon: const Icon(Icons.edit),
                label: const Text('Editar Producto'),
              ),
            )
          ],
        ),
      ),
    );
  }
}