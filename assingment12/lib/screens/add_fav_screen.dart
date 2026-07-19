import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:assingment12/models/fav_model.dart';
import 'package:assingment12/providers/fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddFavScreen extends ConsumerStatefulWidget {
  const AddFavScreen({super.key});

  @override
  ConsumerState<AddFavScreen> createState() => _AddFavScreenState();
}

class _AddFavScreenState extends ConsumerState<AddFavScreen> {
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _placeDescriptionController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? _imageFile;
  Future<void> _pickImage() async {
    XFile? imagePicked = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (imagePicked == null) return;

    setState(() {
      _imageFile = imagePicked;
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please add an image",style: TextStyle(fontSize: 20,fontWeight: FontWeight(500))),
          duration: const Duration(milliseconds: 2000),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.vertical,
        ),
      );

      return;
    }

    ref
        .read(favProvider.notifier)
        .addFav(
          FavModel(
            id: DateTime.now().toString(),
            imagePath: _imageFile!.path,
            name: _placeNameController.text,
            desc: _placeDescriptionController.text,
          ),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Favourite Place',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;
          
          Widget formContent = Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _placeNameController,
                  decoration: const InputDecoration(
                    labelText: "Place Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a place name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  maxLines: null,
                  controller: _placeDescriptionController,
                  decoration: const InputDecoration(
                    labelText: "Place Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a place description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text("Click Image"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: _save, child: const Text("Save")),
              ],
            ),
          );

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: isLargeScreen
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_imageFile != null)
                          Expanded(
                            flex: 1,
                            child: kIsWeb
                                ? Image.network(
                                    _imageFile!.path,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(_imageFile!.path),
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                          )
                        else
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 300,
                              color: Colors.grey[300],
                              child: const Center(child: Text("No Image Selected")),
                            ),
                          ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 1,
                          child: formContent,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        if (_imageFile != null)
                          kIsWeb
                              ? Image.network(
                                  _imageFile!.path,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(_imageFile!.path),
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                        const SizedBox(height: 10),
                        formContent,
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
