import 'package:flutter/material.dart';
import '../data/in_memory_room_repository.dart';
import '../data/furniture.dart';

class DeleteFurnitureCatalogScreen extends StatefulWidget {
  const DeleteFurnitureCatalogScreen({super.key});

  @override
  State<DeleteFurnitureCatalogScreen> createState() => _DeleteFurnitureCatalogScreenState();
}

class _DeleteFurnitureCatalogScreenState extends State<DeleteFurnitureCatalogScreen> {
  final InMemoryRoomRepository _repository = InMemoryRoomRepository();
  Furniture? _selectedFurniture;
  List<Furniture> _catalog = [];

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() {
    setState(() {
      _catalog = _repository.listFurnitureCatalog();
      _selectedFurniture = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete From Catalog')),
      body: _catalog.isEmpty
          ? const Center(child: Text('Catalog is empty'))
          : Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField<Furniture>(
              value: _selectedFurniture,
              hint: const Text("Select Furniture Type to Delete"),
              isExpanded: true,
              items: _catalog.map((f) {
                return DropdownMenuItem(
                  value: f,
                  child: Text("${f.name} (${f.color})"),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedFurniture = val),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                onPressed: () {
                  if (_selectedFurniture != null) {
                    _repository.deleteFurnitureFromCatalog(_selectedFurniture!.id);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Removed from catalog')),
                    );
                  }
                },
                child: const Text('Delete Selected Type'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}