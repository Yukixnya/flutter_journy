import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:assingment12/models/fav_model.dart';
import 'package:flutter/material.dart';

class FavPlaceDetailScreen extends StatelessWidget {
  final FavModel place;
  const FavPlaceDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name, style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLargeScreen = constraints.maxWidth > 600;

          Widget detailsContent = Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        place.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      place.id,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 100, 99, 99),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  place.desc,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 80),
              ],
            ),
          );

          if (isLargeScreen) {
            return SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: kIsWeb
                        ? Image.network(
                            place.imagePath,
                            height: 400,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(place.imagePath),
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    flex: 1,
                    child: detailsContent,
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kIsWeb
                      ? Image.network(
                          place.imagePath,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(place.imagePath),
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                  const SizedBox(height: 5),
                  detailsContent,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
