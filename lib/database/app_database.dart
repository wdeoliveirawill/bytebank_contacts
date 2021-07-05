import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, "bytebank.db");
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDAO.tableSql);
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}
