import '../../databaseObj/speciesDB.dart';
import '../species.dart';
import '../businessObj.dart';


class SpeciesImpl extends BusinessObj
{
  SpeciesDB get _localDbObj => dbObj as SpeciesDB ;

  SpeciesImpl(super.dbObj);

  String get name => _localDbObj.name;
  bool get communUse => _localDbObj.communUse;


  set name(String value)
  {
    _localDbObj.name = value;
  }
  set communUse(bool value)
  {
    _localDbObj.communUse = value;
  }


  static Species newObj(){
    SpeciesDB objDb = SpeciesDB();
    return objDb.newObj();
  }

  static Future<Species> openObj(int id){
    SpeciesDB objDb = SpeciesDB();
    return objDb.open(id);
  }

  static Future<Species> fromMap(Map<String,Object?>map){
    SpeciesDB objDb = SpeciesDB();
    return objDb.fromMap(map);
  }


}