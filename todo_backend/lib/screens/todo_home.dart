import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_backend/data/data.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo App",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          const Icon(Icons.person_rounded, size: 30,),
          const SizedBox(width: 4),
          Text(
            _userName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.redAccent),
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
          const SizedBox(width: 20)
        ],
      ),
      body: ListView.builder(
        itemCount: todo_list.length,
        itemBuilder: (context, index) {
          return TodoEntryCard(entrys: todo_list[index]);
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
                onSave: (entry) {
                  setState(() {
                    todo_list.add(entry);
                  });
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







      // body: SingleChildScrollView(
        // child: Column(
        //   children: [
        //     for(int i=0; i<30; i++)
        //       Card(
        //         color: Colors.amber[300],
        //         elevation: 2.0,
        //         margin: EdgeInsets.all(10.0),
        //         child: Padding(
        //           padding: EdgeInsets.all(16.0),
        //           child: Text('Basic Card Content'),
        //         ),
        //       )
        //   ],
        // )
      // ),
      // body: ListView(
      //   children: [
      //     const JournalEntryCard(),
      //     const JournalEntryCard(),
      //     const JournalEntryCard(),
      //   ],
      // ),