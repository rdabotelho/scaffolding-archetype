import 'package:${context.projectName.toLowerCase()}/config/base_config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    String path = join(dbPath, 'bytebank0001.db');
    return openDatabase(path, onCreate: (db, version) {
      execInitialScripts(db);
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  });
}

abstract class BaseRepository {

}