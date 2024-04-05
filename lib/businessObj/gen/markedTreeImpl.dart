import '../../databaseObj/markedTreeDB.dart';
import '../markedTree.dart';
import '../businessObj.dart';
import '../species.dart';
import '../trunkSize.dart';
import '../campaign.dart';


class MarkedTreeImpl extends BusinessObj
{
  MarkedTreeDB get _localDbObj => dbObj as MarkedTreeDB ;

  MarkedTreeImpl(super.dbObj);

  Species get species => _localDbObj.species;
  int get speciesId => _localDbObj.speciesId;
  TrunkSize get trunkSize => _localDbObj.trunkSize;
  int get trunkSizeId => _localDbObj.trunkSizeId;
  Campaign get campaign => _localDbObj.campaign;
  int get campaignId => _localDbObj.campaignId;
  String get remark => _localDbObj.remark;
  double get latitude => _localDbObj.latitude;
  double get longitude => _localDbObj.longitude;
  DateTime get insertTime => _localDbObj.insertTime;


  set speciesId(int value)
  {
    _localDbObj.speciesId = value;
  }
  set trunkSizeId(int value)
  {
    _localDbObj.trunkSizeId = value;
  }
  set campaignId(int value)
  {
    _localDbObj.campaignId = value;
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
  set insertTime(DateTime value)
  {
    _localDbObj.insertTime = value;
  }


  static MarkedTree newObj(){
    MarkedTreeDB objDb = MarkedTreeDB();
    return objDb.newObj();
  }

  static Future<MarkedTree> openObj(int id){
    MarkedTreeDB objDb = MarkedTreeDB();
    return objDb.open(id);
  }

  static Future<MarkedTree> fromMap(Map<String,Object?>map){
    MarkedTreeDB objDb = MarkedTreeDB();
    return objDb.fromMap(map);
  }


}