import '../databaseObj/markedTreeDBGen.dart';
import '../../businessObj/markedTree.dart';
import '../../businessObj/businessObj.dart';
import '../../businessObj/species.dart';
import '../../businessObj/trunkSize.dart';
import '../../businessObj/campaign.dart';


class MarkedTreeGen extends BusinessObj
{
  MarkedTreeDBGen get _localDbObj => dbObj as MarkedTreeDBGen ;

  MarkedTreeGen(super.dbObj);

  static const String TABLE_NAME = "markedTree";
  static const String COLUMN_ID = "id";
  static const String COLUMN_SPECIESID = "speciesId";
  static const String COLUMN_TRUNKSIZEID = "trunkSizeId";
  static const String COLUMN_CAMPAIGNID = "campaignId";
  static const String COLUMN_REMARK = "remark";
  static const String COLUMN_LATITUDE = "latitude";
  static const String COLUMN_LONGITUDE = "longitude";
  static const String COLUMN_INSERTTIME = "insertTime";
  static const String COLUMN_ALTITUDE = "altitude";



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
  double get altitude => _localDbObj.altitude;


  set species(Species value)
  {
    _localDbObj.species = value;
  }
  set trunkSize(TrunkSize value)
  {
    _localDbObj.trunkSize = value;
  }
  set campaign(Campaign value)
  {
    _localDbObj.campaign = value;
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
  set altitude(double value)
  {
    _localDbObj.altitude = value;
  }


  static MarkedTree newObj(){
    MarkedTreeDBGen objDb = MarkedTreeDBGen();
    return objDb.newObj();
  }

  static Future<MarkedTree> openObj(int id){
    MarkedTreeDBGen objDb = MarkedTreeDBGen();
    return objDb.open(id);
  }

  static Future<MarkedTree> fromMap(Map<String,Object?>map){
    MarkedTreeDBGen objDb = MarkedTreeDBGen();
    return objDb.fromMap(map);
  }

  @override
  MarkedTree clone() {
    MarkedTree result = MarkedTreeGen.newObj(); 

    super.cloneDB(result._localDbObj);
    
    return result ; 
  }

}