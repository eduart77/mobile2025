import 'package:flutter/material.dart';
import '../data/in_memory_room_repository.dart';

class CreateFurnitureCatalogScreen extends StatefulWidget {
  const CreateFurnitureCatalogScreen({super.key});

  @override
  State<CreateFurnitureCatalogScreen> createState() => _CreateFurnitureCatalogScreenState();
}

class _CreateFurnitureCatalogScreenState extends State<CreateFurnitureCatalogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Furniture Type')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Furniture Name (e.g. Sofa)'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _colorController,
                  decoration: const InputDecoration(labelText: 'Color'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _lengthController,
                  decoration: const InputDecoration(labelText: 'Length (m)'),
                  keyboardType: TextInputType.number,
                  validator: (v) => double.tryParse(v!) == null ? 'Invalid number' : null,
                ),
                TextFormField(
                  controller: _widthController,
                  decoration: const InputDecoration(labelText: 'Width (m)'),
                  keyboardType: TextInputType.number,
                  validator: (v) => double.tryParse(v!) == null ? 'Invalid number' : null,
                ),
                TextFormField(
                  controller: _heightController,
                  decoration: const InputDecoration(labelText: 'Height (m)'),
                  keyboardType: TextInputType.number,
                  validator: (v) => double.tryParse(v!) == null ? 'Invalid number' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      InMemoryRoomRepository().createFurnitureInCatalog(
                        _nameController.text,
                        double.parse(_lengthController.text),
                        double.parse(_widthController.text),
                        double.parse(_heightController.text),
                        _colorController.text,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add to Catalog'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}