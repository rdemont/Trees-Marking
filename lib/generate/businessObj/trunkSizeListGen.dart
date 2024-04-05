import '../../businessObj/trunkSize.dart';
import '../../services/databaseService.dart';
import 'trunkSizeGen.dart';



class TrunkSizeListGen
{

  
  static Future<List<TrunkSize>> getAll([String? order]){
    return DatabaseService.initializeDb().then((db) {
      return db.query(TrunkSizeGen.TABLE_NAME,orderBy: order??TrunkSizeGen.COLUMN_ID).then((raws) async {
        List<TrunkSize> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await TrunkSizeGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }
}