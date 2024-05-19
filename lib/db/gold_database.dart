import 'package:gold_calculator/models/setting.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class GoldDatabase {
  static final GoldDatabase instance = GoldDatabase._init();

  static Database? _db;

  GoldDatabase._init();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('sawasgold.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const nameType = "TEXT NOT NULL";
    const valType = "DOUBLE NOT NULL";
    const isPureType = "integer NOT NULL";
    await db.execute('''
CREATE TABLE $tableSetting(
    ${SettingFields.id} $idType,
    ${SettingFields.sname} $nameType,
    ${SettingFields.name} $nameType,
    ${SettingFields.types} $nameType,
    ${SettingFields.val} $valType,
    ${SettingFields.isPure} $isPureType
  )
    ''');
  }

  Future<Setting> insert(Setting setting) async {
    final db = await instance.database;
    //print(setting.toJson());
    int? count = Sqflite.firstIntValue(await db.rawQuery(
        "select count(*) from $tableSetting where sname='${setting.sname}'"));
    int id = 0;
    if (count! > 0) {
      id = await db.update(
          tableSetting,
          {
            'types': setting.types,
            'val': setting.val,
            'isPure': setting.isPure
          },
          where: "sname=? and name=?",
          whereArgs: [setting.sname, setting.name]);
    } else {
      id = await db.insert(tableSetting, setting.toJson());
    }
    return setting.copy(id: id);
  }

  Future<List<Map>> retrieveSetting(String sname) async {
    final db = await instance.database;
    List<Map> list =
        await db.rawQuery("Select * from $tableSetting where sname='$sname'");
    return list;
  }

  void deleteSetting() async {
    final db = await instance.database;
    await db.delete(tableSetting);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
