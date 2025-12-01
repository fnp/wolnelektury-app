import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:wolnelektury/src/application/app_storage/app_storage.dart';
import 'package:wolnelektury/src/domain/hint_model.dart';

class AppStorageSearchService {
  static const int _numberOfLastSearched = 7;
  final AppStorage _storage;

  AppStorageSearchService(this._storage);

  Future<List<HintModel>> readLastSearched() async {
    final results =
        await (_storage.select(_storage.lastSearched)..orderBy([
              (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
            ]))
            .get();
    return results
        .map((e) => HintModel.fromJson(jsonDecode(e.hintJson)))
        .toList();
  }

  Future<bool> insertLastSearched(HintModel hint) async {
    final existingHints = await readLastSearched();
    if (existingHints.any((h) => h.label == hint.label)) {
      // If the hint already exists, remove it first
      await deleteLastSearched(hint.label);
    }
    // Limit the number of stored hints
    if (existingHints.length >= _numberOfLastSearched) {
      // Remove the oldest hint
      await deleteLastSearched(existingHints.last.label);
    }
    // Insert the new hint
    final json = jsonEncode(hint.toJson());
    await _storage
        .into(_storage.lastSearched)
        .insert(
          LastSearchedCompanion.insert(
            hintJson: Value(json),
            label: Value(hint.label),
          ),
        );
    return true;
  }

  Future<void> deleteLastSearched(String label) async {
    await (_storage.delete(
      _storage.lastSearched,
    )..where((t) => t.label.equals(label))).go();
  }
}
