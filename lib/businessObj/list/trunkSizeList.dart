



import '../../services/databaseService.dart';
import '../trunkSize.dart';

class TrunkSizeList
{

  static Future<List<TrunkSize>> getAll(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("trunkSize",orderBy: "name").then((raws){
        return raws.map((e) => TrunkSize.fromMap(e)).toList();
      });
    });
  }

}