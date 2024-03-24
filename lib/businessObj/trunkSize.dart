

import '../databaseObj/trunkSizeDB.dart';
import 'businessObj.dart';

class TrunkSize extends BusinessObj
{
  TrunkSizeDB get _localDbObj => dbObj as TrunkSizeDB ;

  TrunkSize(super.dbObj);

  String get name => _localDbObj.name;
  int get minDiameter => _localDbObj.minDiameter;
  int get maxDiameter => _localDbObj.maxDiameter;


  set name(String value)
  {
    _localDbObj.name = value;
  } 

  set minDiameter(int value)
  {
    _localDbObj.minDiameter = value;
  } 
  
  set maxDiameter(int value)
  {
    _localDbObj.maxDiameter = value;
  } 

  static TrunkSize newObj(){
    TrunkSizeDB objDb = TrunkSizeDB();
    return objDb.newObj();
  }

  static Future<TrunkSize> openObj(int id){
    TrunkSizeDB objDb = TrunkSizeDB();
    return objDb.open(id);
  }


}