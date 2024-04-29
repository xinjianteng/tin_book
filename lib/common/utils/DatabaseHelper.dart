import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../entity/entities.dart';

class DatabaseHelper {
  static const _databaseName = 'csg4.db';
  static const _databaseVersion = 4;

  // Singleton instance to ensure a single database connection.
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  static const _databaseTableShelf = 'shelf';


  Future<Database> _initDatabase() async {
    String sql = '''
      CREATE TABLE $_databaseTableShelf (
        id INTEGER PRIMARY KEY,
        bookId TEXT,
        bookName TEXT,
        bookCover TEXT,
        encryptFilePath TEXT,
        filePath TEXT,
        downloadUrl TEXT,
        rawDownloadUrl TEXT ,
        bookAuthor TEXT,
        isUpload int,
        fileFormat int,
        localFiles TEXT,
        readProgress TEXT
      )
    ''';


    if(GetPlatform.isMobile){
      final dbPath = await getDatabasesPath();
      // /data/user/0/com.example.tin_flutter_book/databases
      final path = join(dbPath, _databaseName);
      Database database=await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: (db, version) async {
          await db.execute(sql);
        },
        // onUpgrade: (db, oldVersion, newVersion) {
        //   // 在数据库升级时执行的操作
        //   if (oldVersion < _databaseVersion) {
        //     // 如果旧版本小于2，执行更新操作
        //     // db.execute('ALTER TABLE timerdata RENAME TO taskdata');
        //   }
        // }
      );
      return database;
    }else{
      sqfliteFfiInit();
      var databaseFactory = databaseFactoryFfi;
      var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      await db.execute(sql);
      return db;
    }

  }

  Future<void> updateDatabase() async {
    // 打开数据库，指定数据库版本
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'your_database.db'),
      version: 2, // 更新数据库版本号
      onCreate: (db, version) {
        // 在数据库首次创建时执行的操作
        db.execute('CREATE TABLE taskdata(id INTEGER PRIMARY KEY, name TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        // 在数据库升级时执行的操作
        if (oldVersion < 2) {
          // 如果旧版本小于2，执行更新操作
          db.execute('ALTER TABLE timerdata RENAME TO taskdata');
        }
      },
    );
    // 关闭数据库连接
    await database.close();
  }


  // 插入图书
  Future<int> insertBookData(DownloadBook book) async {
    final db = await database;
    return await db.insert(_databaseTableShelf, book.toSql());
  }

  //查询图书
  Future<List<DownloadBook>> getShelfBookData() async {
    final db = await database;
    // 嵌套的await示例：先查询主表数据
    final bookResult = await db.query(
      _databaseTableShelf,
    );
    if (bookResult.isEmpty) {
      return [];
    }
    final result=List<DownloadBook>.from(
        bookResult.map((x) => DownloadBook.fromJson(x)));
    return result;
  }

  Future<int> updateBookLocalFilesData(DownloadBook book) async{
    final db = await database;
    return await db.update(_databaseTableShelf, {'localFiles': book.localFiles},
        where: "\"bookId\" = ${book.bookId}");
  }


//  更新阅读进度
  Future<int> updateBookReadProgressData(DownloadBook book) async{
    final db = await database;
    return await db.update(_databaseTableShelf, {'readProgress': book.readProgress},
        where: "\"bookId\" = ${book.bookId}");
  }


  // 清空表数据
  Future<int> clearShelfBookData() async {
    final db = await database;
    return await db.delete(_databaseTableShelf); // 删除所有行，等同于清空表
  }


//  查询图书

// 更新数据的方法...
// 查询数据的方法...
// 删除数据的方法...








}