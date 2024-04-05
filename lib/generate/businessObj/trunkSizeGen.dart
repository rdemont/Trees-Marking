import '../databaseObj/trunkSizeDBGen.dart';
import '../../businessObj/trunkSize.dart';
import '../../businessObj/businessObj.dart';


class TrunkSizeGen extends BusinessObj
{
  TrunkSizeDBGen get _localDbObj => dbObj as TrunkSizeDBGen ;

  TrunkSizeGen(super.dbObj);

  static const String TABLE_NAME = "trunkSize";
  static const String COLUMN_ID = "id";
  static const String COLUMN_MINDIAMETER = "minDiameter";
  static const String COLUMN_MAXDIAMETER = "maxDiameter";
  static const String COLUMN_VOLUME = "volume";
  static const String COLUMN_CODE = "code";
  static const String COLUMN_NAME = "name";



  double get minDiameter => _localDbObj.minDiameter;
  double get maxDiameter => _localDbObj.maxDiameter;
  double get volume => _localDbObj.volume;
  String get code => _localDbObj.code;
  String get name => _localDbObj.name;


  set minDiameter(double value)
  {
    _localDbObj.minDiameter = value;
  }
  set maxDiameter(double value)
  {
    _localDbObj.maxDiameter = value;
  }
  set volume(double value)
  {
    _localDbObj.volume = value;
  }
  set code(String value)
  {
    _localDbObj.code = value;
  }
  set name(String value)
  {
    _localDbObj.name = value;
  }


  static TrunkSize newObj(){
    TrunkSizeDBGen objDb = TrunkSizeDBGen();
    return objDb.newObj();
  }

  static Future<TrunkSize> openObj(int id){
    TrunkSizeDBGen objDb = TrunkSizeDBGen();
    return objDb.open(id);
  }

  static Future<TrunkSize> fromMap(Map<String,Object?>map){
    TrunkSizeDBGen objDb = TrunkSizeDBGen();
    return objDb.fromMap(map);
  }


}