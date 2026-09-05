import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_backend/providers/entry_service_provider.dart';
import 'package:todo_backend/widgets/todo_entry_card.dart';
import 'package:todo_backend/widgets/add_entry_bottom.dart';
import 'package:todo_backend/providers/auth_provider.dart';

class TodoHome extends ConsumerStatefulWidget {
  const TodoHome({super.key});

  @override
  ConsumerState<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends ConsumerState<TodoHome> {
  String _userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.displayName != null && user.displayName!.isNotEmpty) {
        setState(() {
          _userName = user.displayName!;
        });
      }

      final authService = ref.read(authServiceProvider);
      final USName = await authService.getUserName(user.email ?? '');
      if (USName != null && USName.isNotEmpty && mounted) {
        setState(() {
          _userName = USName;
        });
        await user.updateDisplayName(USName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final entriesValue = ref.watch(ToDoEntriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo App",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          const Icon(Icons.person_rounded, size: 30),
          const SizedBox(width: 4),
          Text(
            _userName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Logout',
            onPressed: () async {
              try {
                final authService = ref.read(authServiceProvider);
                await authService.signOut();
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign out failed: $e')),
                  );
                }
              }
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
      // body: ListView.builder(
      //   itemCount: todo_list.length,
      //   itemBuilder: (context, index) {
      //     return TodoEntryCard(entrys: todo_list[index]);
      //   },
      // ),
      body: entriesValue.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) {
          if (error is FirebaseException) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading entries',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ), // Text
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ), // Text
                ],
              ),
            );
          } else {
            return Center(child: Text('An unexpected error occurred: $error'));
          }
        },
        data: (entries) {
          if (entries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.inbox, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No entries found',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to add a new entry.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              return TodoEntryCard(entrys: entries[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return AddEntryBottom(
                onSave: (entry) async {
                  // setState(() {
                  //   todo_list.add(entry);
                  // });
                  try {
                    final service = ref.read(ToDoEntryServiceProvider);
                    await service.addEntry(entry);
                    Navigator.pop(context);
                  } catch (err) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to add entry: $err'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              );
            },
          );
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
