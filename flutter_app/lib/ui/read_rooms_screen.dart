import 'package:flutter/material.dart';
import 'package:room_scan_pro_flutter/data/in_memory_room_repository.dart';
import 'package:room_scan_pro_flutter/data/room.dart';
import 'package:room_scan_pro_flutter/ui/update_room_screen.dart';
import 'package:room_scan_pro_flutter/ui/room_details_screen.dart'; // Import Details Screen

class ReadRoomsScreen extends StatefulWidget {
  const ReadRoomsScreen({super.key});

  @override
  State<ReadRoomsScreen> createState() => _ReadRoomsScreenState();
}

class _ReadRoomsScreenState extends State<ReadRoomsScreen> {
  final InMemoryRoomRepository _repository = InMemoryRoomRepository();
  late List<Room> _rooms;

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() {
    setState(() {
      _rooms = _repository.listRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
      ),
      body: ListView.builder(
        itemCount: _rooms.length,
        itemBuilder: (context, index) {
          final room = _rooms[index];
          return ListTile(
            title: Text(room.name),
            subtitle: Text("${room.furniture.length} items"),
            onTap: () {
              // Tap on the row to view furniture (Read Furniture)
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RoomDetailsScreen(roomId: room.id)
              ));
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateRoomScreen(room: room)));
                    _refreshList();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RoomDetailsScreen(roomId: room.id)
                    ));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}