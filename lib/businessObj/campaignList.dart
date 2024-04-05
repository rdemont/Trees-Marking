import 'campaign.dart';
import '../generate/businessObj/campaignListGen.dart';



class CampaignList extends CampaignListGen
{

  static Future<List<Campaign>> getAll([String? order]){
    return CampaignList.getAll(order);
  }
}