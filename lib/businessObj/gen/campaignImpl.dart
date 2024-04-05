import '../../databaseObj/campaignDB.dart';
import '../campaign.dart';
import '../businessObj.dart';


class CampaignImpl extends BusinessObj
{
  CampaignDB get _localDbObj => dbObj as CampaignDB ;

  CampaignImpl(super.dbObj);

  String get name => _localDbObj.name;
  String get remark => _localDbObj.remark;
  double get latitude => _localDbObj.latitude;
  double get longitude => _localDbObj.longitude;
  DateTime get campaignDate => _localDbObj.campaignDate;


  set name(String value)
  {
    _localDbObj.name = value;
  }
  set remark(String value)
  {
    _localDbObj.remark = value;
  }
  set latitude(double value)
  {
    _localDbObj.latitude = value;
  }
  set longitude(double value)
  {
    _localDbObj.longitude = value;
  }
  set campaignDate(DateTime value)
  {
    _localDbObj.campaignDate = value;
  }


  static Campaign newObj(){
    CampaignDB objDb = CampaignDB();
    return objDb.newObj();
  }

  static Future<Campaign> openObj(int id){
    CampaignDB objDb = CampaignDB();
    return objDb.open(id);
  }

  static Future<Campaign> fromMap(Map<String,Object?>map){
    CampaignDB objDb = CampaignDB();
    return objDb.fromMap(map);
  }


}