


import 'package:treesmarking/businessObj/markedTree.dart';

import '../../services/databaseService.dart';


class MarkedTreeList
{

  
  static Future<List<MarkedTree>> getAll(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("markedTree",orderBy: "insertTime DESC").then((raws) async {
        List<MarkedTree> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await MarkedTree.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }

 
  static Future<List<MarkedTree>> getFromCampaign(int campaignId){
    return DatabaseService.initializeDb().then((db) {
      return db.query("markedTree",where: "campaignId = $campaignId" ,orderBy: "insertTime DESC").then((raws) async {
        List<MarkedTree> result = [];      
        for(int i=0;i<raws.length;i++)
        {
          result.add(await MarkedTree.fromMap(raws[i]));
          
        }
        return result;
      });
    });
  }

}