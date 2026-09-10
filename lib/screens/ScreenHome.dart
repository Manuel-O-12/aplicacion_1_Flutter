import 'package:flutter/material.dart';

class Screenhome extends StatelessWidget {

  const Screenhome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productos = [
      {"Name": "Coca-cola 600ml", "Stock": 45, "Precio": "\20.00" },
      {"Name": "Chetos", "Stock": 15, "Precio": "\25.00" },
      {"Name": "Barritas", "Stock": 25, "Precio": "\16.00" },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario Actual'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('BIENVENIDO',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(producto["Icon"], color: Colors.blueAccent),
                        ),
                      
                      title: Text(producto["Name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('En bodega: ${producto["stock"]} unidades'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: (){
                        print("Seleccionaste ${producto['nombre']} - Falta programar navegación");
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Botón Agregar presionado");
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );

  }
}