import 'dart:math';

import 'room.dart';

class InMemoryRoomRepository {
  static final InMemoryRoomRepository _instance = InMemoryRoomRepository._internal();

  factory InMemoryRoomRepository() {
    return _instance;
  }

  InMemoryRoomRepository._internal() {
    _rooms.add(Room(id: _generateUuid(), name: 'Living Room', type: 'Living Room', length: 5.0, width: 4.0, height: 2.7));
    _rooms.add(Room(id: _generateUuid(), name: 'Bedroom', type: 'Bedroom', length: 4.0, width: 3.2, height: 2.7));
  }

  final List<Room> _rooms = [];

  List<Room> listRooms() => _rooms;

  Room createRoom(String name, String type, double length, double width, double height) {
    final newRoom = Room(id: _generateUuid(), name: name, type: type, length: length, width: width, height: height);
    _rooms.add(newRoom);
    return newRoom;
  }

  Room? findRoom(String id) {
    try {
      return _rooms.firstWhere((room) => room.id == id);
    } catch (e) {
      return null;
    }
  }

  bool updateRoom(String id, String name, String type, double length, double width, double height) {
    final room = findRoom(id);
    if (room == null) {
      return false;
    }
    room.name = name;
    room.type = type;
    room.length = length;
    room.width = width;
    room.height = height;
    return true;
  }

  bool deleteRoom(String id) {
    final room = findRoom(id);
    if (room == null) {
      return false;
    }
    return _rooms.remove(room);
  }

  String _generateUuid() {
    return List.generate(16, (index) => Random().nextInt(256))
        .map((i) => i.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}
