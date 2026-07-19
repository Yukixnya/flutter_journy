import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:assingment12/providers/fav_provider.dart';
import 'package:assingment12/screens/add_fav_screen.dart';
import 'package:assingment12/screens/fav_place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool("isFirstTime") ?? true;

    if (isFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showWelcomeDialog();
      });
      prefs.setBool("isFirstTime", false);
    }
  }

  void showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Welcome!", style: Theme.of(context).textTheme.bodyLarge),
          content: const Text(
            "Thanks for Installing!.\nKeep your fav palces together.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Got It!"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final favPlaces = ref.watch(favProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourite Places',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: favPlaces.isEmpty
          ? Center(child: const Text("No Favourite Places Added Yet!"))
          : LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Tablet / Large Screen layout
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: favPlaces.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  FavPlaceDetailScreen(place: favPlaces[index]),
                            ),
                          );
                        },
                        child: Card(
                          child: GridTile(
                            footer: GridTileBar(
                              backgroundColor: Colors.black54,
                              title: Text(favPlaces[index].name),
                              subtitle: Text(
                                favPlaces[index].desc.length > 24
                                    ? "${favPlaces[index].desc.substring(0, 24)}..."
                                    : favPlaces[index].desc,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  ref
                                      .read(favProvider.notifier)
                                      .removeFav(favPlaces[index]);
                                },
                                icon: const Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            child: kIsWeb
                                ? Image.network(
                                    favPlaces[index].imagePath,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(favPlaces[index].imagePath),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  // Mobile layout
                  return ListView.builder(
                    itemCount: favPlaces.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  FavPlaceDetailScreen(place: favPlaces[index]),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: kIsWeb
                                ? Image.network(
                                    favPlaces[index].imagePath,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(favPlaces[index].imagePath),
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                            title: Text(favPlaces[index].name),
                            subtitle: Text(
                              favPlaces[index].desc.length > 24
                                  ? "${favPlaces[index].desc.substring(0, 24)}..."
                                  : favPlaces[index].desc,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                ref
                                    .read(favProvider.notifier)
                                    .removeFav(favPlaces[index]);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const AddFavScreen())),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
