import 'package:flutter/material.dart';
import 'package:room_scan_pro_flutter/data/in_memory_room_repository.dart'; // <--- This was missing
import 'package:room_scan_pro_flutter/data/room.dart';
import 'create_furniture_screen.dart';

class RoomDetailsScreen extends StatefulWidget {
  final String roomId;
  const RoomDetailsScreen({super.key, required this.roomId});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  final InMemoryRoomRepository _repository = InMemoryRoomRepository();
  Room? _room;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _room = _repository.findRoom(widget.roomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_room == null) return const Scaffold(body: Center(child: Text("Room not found")));

    return Scaffold(
      appBar: AppBar(title: Text(_room!.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Furniture List", style: Theme.of(context).textTheme.headlineSmall),
          ),
          Expanded(
            child: _room!.furniture.isEmpty
                ? const Center(child: Text("No furniture in this room."))
                : ListView.builder(
              itemCount: _room!.furniture.length,
              itemBuilder: (ctx, i) {
                final f = _room!.furniture[i];
                return ListTile(
                  leading: CircleAvatar(child: Text(f.name.isNotEmpty ? f.name[0] : "?")),
                  title: Text(f.name),
                  subtitle: Text("Color: ${f.color}\n${f.length}x${f.width}x${f.height}m"),
                  isThreeLine: true,
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
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => CreateFurnitureScreen(roomId: widget.roomId)));
                      _refresh();
                    },
                    child: const Text("Add Furniture"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100, foregroundColor: Colors.red),
                    onPressed: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => DeleteFurnitureScreen(roomId: widget.roomId)));
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