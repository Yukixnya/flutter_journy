import 'dart:io';

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
  File? _imageFile;
  Future<void> _pickImage() async {
    XFile? imagePicked = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (imagePicked == null) return;

    setState(() {
      _imageFile = File(imagePicked.path);
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
            image: _imageFile!,
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // image picker
                if (_imageFile != null)
                  Image.file(
                    _imageFile!,
                    width: 400,
                    height: 200,
                    fit: BoxFit.cover,
                  ),

                const SizedBox(height: 10),

                // form
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
                SizedBox(height: 20),
                ElevatedButton(onPressed: _save, child: const Text("Save")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
