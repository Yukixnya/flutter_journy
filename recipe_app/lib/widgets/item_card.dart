// Text("${categoryItems[index].name}",style:TextStyle(color: Colors.white));

import 'package:flutter/material.dart';
import 'package:recipe_app/models/item_model.dart';
import 'package:recipe_app/screens/item_details_page.dart';

class ItemCard extends StatelessWidget {
  final ItemModel items;
  const ItemCard({required this.items, super.key});

  @override
  Widget build(BuildContext context) {

    final String type = items.isVeg? "assets/veg.jpeg" : "assets/non_veg.jpeg";

    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          // print(items.name);
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => ItemDetailsPage(
                items: items,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child:Image.network(
                items.img,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: 250,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    height: 250,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image, size: 48, color: Colors.grey),
                          const SizedBox(height: 8),
                          Text('Failed to load image', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Positioned(
              top: 12,
              left: 12,
              child: SizedBox(
                height: 40,
                child: Image.asset(type),
              ),
            ),
            Positioned(
              bottom: 1,
              right: 2,
              left: 1,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer,color: Colors.white,),
                            Text(
                              items.time,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          "Rs.${items.cost}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      
                        Row(
                          children: [
                            Icon(Icons.work,color: Colors.white),
                            Text(
                              " ${items.complexity.name}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      
                        Row(
                          children: [
                            Icon(Icons.attach_money_outlined,color: Colors.white),
                            Text(
                              items.affordability.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
