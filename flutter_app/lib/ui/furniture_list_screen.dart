import 'package:flutter/material.dart';
import '../data/in_memory_room_repository.dart';
import '../data/furniture.dart';
import 'create_furniture_catalog_screen.dart';
import 'delete_furniture_catalog_screen.dart';

class FurnitureListScreen extends StatefulWidget {
  const FurnitureListScreen({super.key});

  @override
  State<FurnitureListScreen> createState() => _FurnitureListScreenState();
}

class _FurnitureListScreenState extends State<FurnitureListScreen> {
  final InMemoryRoomRepository _repository = InMemoryRoomRepository();
  List<Furniture> _catalog = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _catalog = _repository.listFurnitureCatalog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Furniture Catalog')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _catalog.length,
              itemBuilder: (ctx, i) {
                final f = _catalog[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    child: Text(f.name.isNotEmpty ? f.name[0] : "?"),
                  ),
                  title: Text(f.name),
                  subtitle: Text("Color: ${f.color} - ${f.length}x${f.width}x${f.height}"),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateFurnitureCatalogScreen()));
                      _refresh();
                    },
                    child: const Text("Create New Furniture"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100, foregroundColor: Colors.red),
                    onPressed: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => const DeleteFurnitureCatalogScreen()));
                      _refresh();
                    },
                    child: const Text("Delete Furniture"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}