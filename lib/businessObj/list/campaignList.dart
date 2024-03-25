



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

}