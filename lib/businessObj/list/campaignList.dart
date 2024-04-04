



import '../../services/databaseService.dart';
import '../campaign.dart';

class CampaignList
{

  
  static Future<List<Campaign>> getAll(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("campaign",orderBy: "campaignDate DESC").then((raws){
        return raws.map((e) => Campaign.fromMap(e)).toList();
      });
    });
  }

  static Future<Map<int, Campaign>> getObjectsMap(){
    return DatabaseService.initializeDb().then((db) {
      return db.query("campaign",orderBy: "id").then((raws){
        Map<int, Campaign> result = {} ;
        for (int i=0;i<raws.length;i++)
        {
          Campaign obj = Campaign.fromMap(raws[i]);

          result[obj.id]  = obj;
          
        }
        return result ; 
      });
    });
  }


}