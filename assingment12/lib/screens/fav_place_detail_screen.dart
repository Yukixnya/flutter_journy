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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(
              place.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        place.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(place.id,style: TextStyle(fontSize: 15,color: const Color.fromARGB(255, 100, 99, 99))),
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
            ),
          ],
        ),
      ),
    );
  }
}
