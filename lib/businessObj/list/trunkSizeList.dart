



import '../../services/databaseService.dart';
import '../trunkSize.dart';

class TrunkSizeList
{

  static Future<List<TrunkSize>> getAll(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("trunkSize",orderBy: "minDiameter").then((raws){
        return raws.map((e) => TrunkSize.fromMap(e)).toList();
      });
    });
  }

}