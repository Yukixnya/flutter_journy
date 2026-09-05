import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_backend/data/todo_entry_model.dart';

class EntryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // add new entry
  Future<void> addEntry(TodoEntryModel entry) async {
    try {
      final docID = _auth.currentUser!.uid;
      await _firestore
          .collection('users')
          .doc(docID)
          .collection('entries')
          .add(entry.toMap());
    } catch (e) {
      throw FirebaseException(code: 'failed-to-add-entry', message: 'Failed to add entry: $e', plugin: 'flutter_journy');
    }
  }

  //delete entry
  Future<void> deleteEntry(String entryId) async {
    try {
      final docID = _auth.currentUser!.uid;
      await _firestore
          .collection('users')
          .doc(docID)
          .collection('entries')
          .doc(entryId)
          .delete();
    } catch (e) {
      throw FirebaseException(code: 'failed-to-delete-entry', message: 'Failed to delete entry: $e', plugin: 'flutter_journy');
    }
  }

  // get all entries stream of entries
  Stream<List<TodoEntryModel>> getEntries() {
    try {
      final docID = _auth.currentUser!.uid;
      return _firestore
          .collection('users')
          .doc(docID)
          .collection('entries')
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => TodoEntryModel.fromFirestore(doc))
                .toList(),
          );
    } catch (e) {
      throw FirebaseException(code: 'failed-to-get-entries', message: 'Failed to get entries: $e', plugin: 'flutter_journy');
    }

  }
}
