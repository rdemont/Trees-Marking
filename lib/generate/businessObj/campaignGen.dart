import '../databaseObj/campaignDBGen.dart';
import '../../businessObj/campaign.dart';
import '../../businessObj/businessObj.dart';


class CampaignGen extends BusinessObj
{
  CampaignDBGen get _localDbObj => dbObj as CampaignDBGen ;

  CampaignGen(super.dbObj);

  static const String TABLE_NAME = "campaign";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_REMARK = "remark";
  static const String COLUMN_LATITUDE = "latitude";
  static const String COLUMN_LONGITUDE = "longitude";
  static const String COLUMN_CAMPAIGNDATE = "campaignDate";



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
    CampaignDBGen objDb = CampaignDBGen();
    return objDb.newObj();
  }

  static Future<Campaign> openObj(int id){
    CampaignDBGen objDb = CampaignDBGen();
    return objDb.open(id);
  }

  static Future<Campaign> fromMap(Map<String,Object?>map){
    CampaignDBGen objDb = CampaignDBGen();
    return objDb.fromMap(map);
  }


}