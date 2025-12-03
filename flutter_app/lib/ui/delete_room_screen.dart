import 'package:flutter/material.dart';
import '../data/in_memory_room_repository.dart';
import '../data/room.dart';

class DeleteRoomScreen extends StatefulWidget {
  const DeleteRoomScreen({super.key});

  @override
  State<DeleteRoomScreen> createState() => _DeleteRoomScreenState();
}

class _DeleteRoomScreenState extends State<DeleteRoomScreen> {
  final InMemoryRoomRepository _repository = InMemoryRoomRepository();
  Room? _selectedRoom;
  List<Room> _rooms = [];

  @override
  void initState() {
    super.initState();
    _refreshRooms();
  }

  void _refreshRooms() {
    setState(() {
      _rooms = _repository.listRooms();
      // Reset selected room if the list is empty or the selected one is gone
      if (_rooms.isNotEmpty) {
        if (_selectedRoom == null || !_rooms.contains(_selectedRoom)) {
          _selectedRoom = _rooms.first;
        }
      } else {
        _selectedRoom = null;
      }
    });
  }

  // This function handles the delete logic
  void _confirmAndDelete() {
    if (_selectedRoom == null) return;

    showDialog(
      context: context,
      barrierDismissible: false, // Force user to tap a button to close
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete "${_selectedRoom!.name}"?'),
          actions: <Widget>[
            // CANCEL BUTTON
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Just close the dialog
              },
            ),
            // DELETE BUTTON
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                // 1. Perform the delete
                _repository.deleteRoom(_selectedRoom!.id);

                // 2. Close the dialog
                Navigator.of(context).pop();

                // 3. Go back to the main menu
                if (mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Room successfully deleted')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Room'),
      ),
      body: Center(
        child: _rooms.isEmpty
            ? const Text('No rooms to delete')
            : Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select a room to delete:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Room>(
                initialValue: _selectedRoom,
                isExpanded: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: _rooms.map((room) {
                  return DropdownMenuItem(
                    value: room,
                    child: Text(room.name),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedRoom = val;
                  });
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _confirmAndDelete, // Calls the dialog function
                  child: const Text('Delete Room'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}