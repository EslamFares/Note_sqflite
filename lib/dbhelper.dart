import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_flutter/model/course.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database _db;
  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    String path = join(await getDatabasesPath(), 'school.db');
    _db = await openDatabase(path, version: 2, onCreate: (Database db, int v) {
      db.execute(
          'create table courses(id integer primary key autoincrement, name varchar(50), content varchar(500), hours varchar(5), color integer)');
    }, onUpgrade: (Database db, int oldV, int newV) async {
      if (oldV < newV) {
        await db.execute('alter table courses add column selcolornum integer');
      }
    });
    return _db;
  }

  Future<int> createCourse(Course course) async {
    Database db = await createDatabase();
    return db.insert('courses', course.toMAp());
  }

  Future<List> allCourses() async {
    Database db = await createDatabase();
    return db.query('courses');
  }

  delete(int id) async {
    Database db = await createDatabase();
    return db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> upDate(Course course) async {
    Database db = await createDatabase();
    return await db.update('courses', course.toMAp(),
        where: 'id = ?', whereArgs: [course.id]);
  }
}
