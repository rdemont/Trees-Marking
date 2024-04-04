import 'package:treesmarking/databaseObj/trunkSizeDB.dart';

import 'businessObj.dart';
import 'trunkSize.dart';

class TrunkSizeImpl extends BusinessObj
{
  TrunkSizeDB get _localDbObj => dbObj as TrunkSizeDB ;

  TrunkSizeImpl(super.dbObj);

	
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