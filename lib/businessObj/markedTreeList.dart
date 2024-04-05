import '../generate/businessObj/markedTreeGen.dart';
import '../services/databaseService.dart';
import 'markedTree.dart';
import '../generate/businessObj/markedTreeListGen.dart';



class MarkedTreeList extends MarkedTreeListGen
{

  static Future<List<MarkedTree>> getAll([String? order]){
    return MarkedTreeListGen.getAll(order);
  }


  
  static Future<List<MarkedTree>> getFromCampaign(int campaignId){
    return DatabaseService.initializeDb().then((db) {
      return db.query("markedTree",where: "campaignId = $campaignId" ,orderBy: "insertTime DESC").then((raws) async {
        List<MarkedTree> result = [];      
        for(int i=0;i<raws.length;i++)
        {
          result.add(await MarkedTreeGen.fromMap(raws[i]));
          
        }
        return result;
      });
    });
  }
}