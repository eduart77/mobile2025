import 'package:flutter/material.dart';
import 'package:room_scan_pro_flutter/data/in_memory_room_repository.dart';
import 'package:room_scan_pro_flutter/data/room.dart';
import 'package:room_scan_pro_flutter/ui/update_room_screen.dart';

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
    _rooms = _repository.listRooms();
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateRoomScreen(room: room)));
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Room'),
                        content: const Text('Are you sure you want to delete this room?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _repository.deleteRoom(room.id);
                                _rooms = _repository.listRooms();
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
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
