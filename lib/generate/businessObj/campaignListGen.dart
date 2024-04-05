import '../../businessObj/campaign.dart';
import '../../services/databaseService.dart';
import 'campaignGen.dart';



class CampaignListGen
{

  
  static Future<List<Campaign>> getAll([String? order]){
    return DatabaseService.initializeDb().then((db) {
      return db.query(CampaignGen.TABLE_NAME,orderBy: order??CampaignGen.COLUMN_ID).then((raws) async {
        List<Campaign> result = [];
        for (int i = 0 ; i< raws.length;i++)
        {
          result.add(await CampaignGen.fromMap(raws[i]));
        }
        return result ; 
      });
    });
  }
}