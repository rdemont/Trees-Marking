import '../../businessObj/markedTree.dart';
import '../../services/databaseService.dart';
import 'markedTreeGen.dart';



class MarkedTreeListGen
{

  
  static Future<List<MarkedTree>> getAll([String? order]){
    return DatabaseService.initializeDb().then((db) {
      return db.query(MarkedTreeGen.TABLE_NAME,orderBy: order??MarkedTreeGen.COLUMN_ID).then((raws) async {
        List<MarkedTree> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await MarkedTreeGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }
}