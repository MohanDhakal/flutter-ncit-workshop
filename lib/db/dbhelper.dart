import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:start_app/noteapp/model.dart';

class DbHelper {
  Future<Database> _openDb() async {
    // Open the database and store the reference.
    Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'note_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, body INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  Future<void> insertNote(Note note) async {
    // Get a reference to the database.
    final Database db = await _openDb();

    // Insert the Note into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same note is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'note',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> getAllNotes() async {
    // Get a reference to the database.
    final Database db = await _openDb();

    // Query the table for all The Note.
    final List<Map<String, dynamic>> maps = await db.query('note');

    // Convert the List<Map<String, dynamic> into a List<Note>.
    return List.generate(maps.length, (i) {
      return Note.name(
        maps[i]['id'],
        maps[i]['title'],
        maps[i]['body'],
      );
    });
  }

  Future<void> updateNote(Note note) async {
    // Get a reference to the database.
    final db = await _openDb();

    // Update the given note.
    await db.update(
      'note',
      note.toMap(),
      // Ensure that the Note has a matching id.
      where: "id = ?",
      // Pass the Notes's id as a whereArg to prevent SQL injection.
      whereArgs: [note.id],
    );
    print(note.id);
  }

  Future<void> deleteNote(int id) async {
    // Get a reference to the database.
    final db = await _openDb();

    // Remove the Note from the database.
    await db.delete(
      'note',
      // Use a `where` clause to delete a specific note.
      where: "id = ?",
      // Pass the Note's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
