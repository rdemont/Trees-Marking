import '../databaseObj/speciesDBGen.dart';
import '../../businessObj/species.dart';
import '../../businessObj/businessObj.dart';


class SpeciesGen extends BusinessObj
{
  SpeciesDBGen get _localDbObj => dbObj as SpeciesDBGen ;

  SpeciesGen(super.dbObj);

  static const String TABLE_NAME = "species";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_CODE = "code";
  static const String COLUMN_TYPE = "type";
  static const String COLUMN_COMMUNUSE = "communUse";



  String get name => _localDbObj.name;
  String get code => _localDbObj.code;
  int get type => _localDbObj.type;
  bool get communUse => _localDbObj.communUse;


  set name(String value)
  {
    _localDbObj.name = value;
  }
  set code(String value)
  {
    _localDbObj.code = value;
  }
  set type(int value)
  {
    _localDbObj.type = value;
  }
  set communUse(bool value)
  {
    _localDbObj.communUse = value;
  }


  static Species newObj(){
    SpeciesDBGen objDb = SpeciesDBGen();
    return objDb.newObj();
  }

  static Future<Species> openObj(int id){
    SpeciesDBGen objDb = SpeciesDBGen();
    return objDb.open(id);
  }

  static Future<Species> fromMap(Map<String,Object?>map){
    SpeciesDBGen objDb = SpeciesDBGen();
    return objDb.fromMap(map);
  }


}