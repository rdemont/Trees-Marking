


import 'package:treesmarking/businessObj/markedTree.dart';
import 'package:treesmarking/databaseObj/campaignDB.dart';

import 'businessObj.dart';

class Campaign extends BusinessObj
{
  CampaignDB get _localDbObj => dbObj as CampaignDB ;

  Campaign(super.dbObj);

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

  Future<List<MarkedTree>> markedTreeList()
  {
    return _localDbObj.markedTreeList();
  }  

  static Campaign newObj(){
    CampaignDB objDb = CampaignDB();
    return objDb.newObj();
  }

  static Future<Campaign> openObj(int id){
    CampaignDB objDb = CampaignDB();
    return objDb.open(id);
  }



}