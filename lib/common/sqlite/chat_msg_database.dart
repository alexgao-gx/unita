import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unitaapp/common/sqlite/chat_msg.dart';

class ChatMsgDatabase {
  static final ChatMsgDatabase instance = ChatMsgDatabase._init();

  static Database? _database;

  ChatMsgDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('msg.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${ChatMsgFields.id} $idType, 
  ${ChatMsgFields.sendMsg} $textType,
  ${ChatMsgFields.createdTime} $integerType,
  ${ChatMsgFields.isSending} $integerType,
  ${ChatMsgFields.receiveMsg} $textType,
  ${ChatMsgFields.isHiMsg} $integerType
  )
''');
  }

  Future<ChatMsg> create(ChatMsg note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<ChatMsg> readChat(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: ChatMsgFields.values,
      where: '${ChatMsgFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ChatMsg.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ChatMsg>> readAllChat() async {
    final db = await instance.database;

    // const orderBy = '${ChatMsgFields.isHiMsg} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes); //, orderBy: orderBy

    return result.map((json) => ChatMsg.fromJson(json)).toList();
  }

  Future<int> update(ChatMsg note) async {
    final db = await instance.database;
    return db.update(
      tableNotes,
      note.toJson(),
      where: '${ChatMsgFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableNotes,
      where: '${ChatMsgFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
