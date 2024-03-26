import 'package:treesmarking/databaseObj/markedTreeDB.dart';

import 'businessObj.dart';

class MarkedTree extends BusinessObj
{
  MarkedTreeDB get _localDbObj => dbObj as MarkedTreeDB ;

  MarkedTree(super.dbObj);

	
  int get speciesId => _localDbObj.speciesId;
int get trunkSizeId => _localDbObj.trunkSizeId;
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

  static MarkedTree fromMap(Map<String,Object?>map){
    MarkedTreeDB objDb = MarkedTreeDB();
    return objDb.fromMap(map);
  }


}