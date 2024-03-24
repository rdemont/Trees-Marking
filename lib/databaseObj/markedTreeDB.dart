import 'dart:core';

import 'package:treesmarking/businessObj/campaign.dart';
import 'package:treesmarking/businessObj/markedTree.dart';
import 'package:treesmarking/businessObj/species.dart';
import 'package:treesmarking/businessObj/trunkSize.dart';
import 'package:treesmarking/databaseObj/databaseObj.dart';

class MarkedTreeDB extends DatabaseObj {
  
  int _speciesId = 0 ; 
  int _trunkSizeId = 0 ; 
  int _campaignId = 0 ; 
  Species? _species  ;
  TrunkSize? _trunkSize  ;
  Campaign? _campaign ; 
  String _remark ='' ;
  double _latitude = 0.0;
  double _longitude = 0.0;
  DateTime _insertTime = DateTime.now();

  markedTreeDB()
  {
    tableName = 'markedTree';
  }

  Species? get species{
    if ((_species == null)&& (_speciesId > 0))
    {
        Species.openObj(_speciesId).then((value) => _species = value);
    }
      
    return _species ; 
  }
   
  TrunkSize? get trunkSize{
    if ((_trunkSize == null)&& (_trunkSizeId > 0))
    {
        TrunkSize.openObj(_trunkSizeId).then((value) => _trunkSize = value);
    }
      
    return _trunkSize ; 
  }

  Campaign? get campaign{
    if ((_campaign == null)&& (_campaignId > 0))
    {
        Campaign.openObj(_campaignId).then((value) => _campaign = value);
    }
      
    return _campaign ; 
  }


  String get remark => _remark;
  double get latitude => _latitude;
  double get longitude => _longitude;
  DateTime get insertTime => _insertTime;

  set species(Species? value)
  {
    if (_species != value)
    {
      dataUpdated(); 
      _species = value;
    }
  }

  set trunkSize(TrunkSize? value)
  {
    if (_trunkSize != value)
    {
      dataUpdated(); 
      _trunkSize = value;
    }
  }

  set campaign(Campaign? value)
  {
    if (_campaign != value)
    {
      dataUpdated(); 
      _campaign = value;
    }
  }


  set remark(String value)
  {
    if (_remark != value)
    {
      dataUpdated(); 
      _remark = value;
    }
  }

  set latitude(double value)
  {
    if (_latitude != value)
    {
      dataUpdated(); 
      _latitude = value;
    }
  }


  set longitude(double value)
  {
    if (_longitude != value)
    {
      dataUpdated(); 
      _longitude = value;
    }
  }

  set insertTime(DateTime value)
  {
    if (_insertTime != value)
    {
      dataUpdated(); 
      _insertTime = value;
    }
  }


  MarkedTree fromMap(Map<String, Object?> map){
    MarkedTree result = MarkedTree(this) ;
    super.id = map["id"] as int; 
    _speciesId = map["specieId"] as int; 
    _trunkSizeId = map["trunkSizeId"] as int; 
    _campaignId = map["campaignId"] as int; 
    _remark = map["remark"] as String; 
    _latitude = map["latitude"] as double; 
    _longitude = map["longitude"] as double; 
    _insertTime = map["insertTime"] as DateTime; 

    return result; 
  }

  Future<MarkedTree> open(int id)
  {
    return query(tableName,where: "id = $id").then((obj){
      MarkedTree result = MarkedTree(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);        
      }
      return result ; 
    });
  }

  MarkedTree newObj()
  {
    MarkedTree result = MarkedTree(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    Map<String, Object?> result = super.toMap();
    result.addAll({
      'speciesId':_species!= null ? _species?.id : _speciesId,
      'trunkSizeId': _trunkSize != null ? trunkSize?.id : _trunkSizeId ,
      'campaignId': _campaign != null ? campaign?.id : _campaignId, 
      'remark': _remark,
      'latitude': _latitude,
      'longitude': _longitude,
      'insertTime': _insertTime 
    });
    return  result ; 
  }




}