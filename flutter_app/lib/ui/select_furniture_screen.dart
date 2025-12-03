import 'package:flutter/material.dart';
import '../data/in_memory_room_repository.dart';
import '../data/furniture.dart';

class SelectFurnitureScreen extends StatefulWidget {
  final String roomId;
  const SelectFurnitureScreen({super.key, required this.roomId});

  @override
  State<SelectFurnitureScreen> createState() => _SelectFurnitureScreenState();
}

class _SelectFurnitureScreenState extends State<SelectFurnitureScreen> {
  final InMemoryRoomRepository _repository = InMemoryRoomRepository();
  List<Furniture> _catalog = [];

  @override
  void initState() {
    super.initState();
    _catalog = _repository.listFurnitureCatalog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Furniture to Add')),
      body: _catalog.isEmpty
          ? const Center(child: Text("No furniture in catalog. Create some first."))
          : ListView.builder(
        itemCount: _catalog.length,
        itemBuilder: (context, index) {
          final item = _catalog[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text("Color: ${item.color}"),
            trailing: const Icon(Icons.add_circle_outline),
            onTap: () {
              // Add this furniture to the room
              _repository.addFurnitureToRoom(widget.roomId, item);
              Navigator.pop(context); // Go back to room details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Added ${item.name} to room")),
              );
            },
          );
        },
      ),
    );
  }
}