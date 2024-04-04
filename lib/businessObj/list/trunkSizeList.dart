



import '../../services/databaseService.dart';
import '../trunkSize.dart';
import '../trunkSizeImpl.dart';

class TrunkSizeList
{

  static Future<List<TrunkSize>> getAll(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("trunkSize",orderBy: "minDiameter").then((raws){
        return raws.map((e) => TrunkSizeImpl.fromMap(e)).toList();
      });
    });
  }

  static Future<Map<int, TrunkSize>> getObjectsMap(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("campaign",orderBy: "id").then((raws){
        Map<int, TrunkSize> result = {} ;
        for (int i=0;i<raws.length;i++)
        {
          TrunkSize obj = TrunkSizeImpl.fromMap(raws[i]);

          result[obj.id]  = obj;
          
        }
        return result ; 
      });
    });
  }

}