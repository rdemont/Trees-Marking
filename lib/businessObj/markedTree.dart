

import 'package:treesmarking/businessObj/businessObj.dart';
import 'package:treesmarking/databaseObj/markedTreeDB.dart';

import 'species.dart';
import 'trunkSize.dart';

class MarkedTree extends BusinessObj
{
  MarkedTreeDB get _localDbObj => dbObj as MarkedTreeDB ;

  MarkedTree(super.dbObj);
  
  //int get specieId => _localDbObj.specieId;
  //int get trunkSizeId => _localDbObj.trunkSizeId;
  String get remark => _localDbObj.remark;
  double get latitude => _localDbObj.latitude;
  double get longitude => _localDbObj.longitude;
  DateTime get insertTime => _localDbObj.insertTime;

  Species? get specie{
    return _localDbObj.species;
  } 

  TrunkSize? get trunkSize{
    return _localDbObj.trunkSize;
  }

  set specie(Species? value)
  {
    _localDbObj.species = value;
  } 


  set trunkSize(TrunkSize? value)
  {
    _localDbObj.trunkSize = value;
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

  static MarkedTree fromMap(Map<String, Object?> map){
    MarkedTreeDB objDb = MarkedTreeDB();
    return objDb.fromMap(map);

  }


}