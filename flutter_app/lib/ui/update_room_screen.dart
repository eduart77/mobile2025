import 'package:flutter/material.dart';
import 'package:room_scan_pro_flutter/data/in_memory_room_repository.dart';
import 'package:room_scan_pro_flutter/data/room.dart';

class UpdateRoomScreen extends StatefulWidget {
  final Room room;

  const UpdateRoomScreen({super.key, required this.room});

  @override
  State<UpdateRoomScreen> createState() => _UpdateRoomScreenState();
}

class _UpdateRoomScreenState extends State<UpdateRoomScreen> {
  final InMemoryRoomRepository _repository = InMemoryRoomRepository();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _lengthController;
  late TextEditingController _widthController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.room.name);
    _typeController = TextEditingController(text: widget.room.type);
    _lengthController = TextEditingController(text: widget.room.length.toString());
    _widthController = TextEditingController(text: widget.room.width.toString());
    _heightController = TextEditingController(text: widget.room.height.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Room Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Room Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lengthController,
                decoration: const InputDecoration(labelText: 'Length (m)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a length';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _widthController,
                decoration: const InputDecoration(labelText: 'Width (m)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a width';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height (m)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a height';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _repository.updateRoom(
                      widget.room.id,
                      _nameController.text,
                      _typeController.text,
                      double.parse(_lengthController.text),
                      double.parse(_widthController.text),
                      double.parse(_heightController.text),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
