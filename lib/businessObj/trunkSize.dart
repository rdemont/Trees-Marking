import 'package:treesmarking/databaseObj/trunkSizeDB.dart';

import 'businessObj.dart';

class TrunkSize extends BusinessObj
{
  TrunkSizeDB get _localDbObj => dbObj as TrunkSizeDB ;

  TrunkSize(super.dbObj);

	
  int get minDiameter => _localDbObj.minDiameter;
int get maxDiameter => _localDbObj.maxDiameter;
String get name => _localDbObj.name;


  
                    set minDiameter(int value)
                    {
                        _localDbObj.minDiameter = value;
                    } 
                
                    set maxDiameter(int value)
                    {
                        _localDbObj.maxDiameter = value;
                    } 
                
                    set name(String value)
                    {
                        _localDbObj.name = value;
                    } 
                

  static TrunkSize newObj(){
    TrunkSizeDB objDb = TrunkSizeDB();
    return objDb.newObj();
  }

  static Future<TrunkSize> openObj(int id){
    TrunkSizeDB objDb = TrunkSizeDB();
    return objDb.open(id);
  }

  static TrunkSize fromMap(Map<String,Object?>map){
    TrunkSizeDB objDb = TrunkSizeDB();
    return objDb.fromMap(map);
  }


}