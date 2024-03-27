

import '../businessObj/markedTree.dart';
import 'databaseObj.dart';

class MarkedTreeDB extends DatabaseObj {
  


  int _speciesId = 0;
int _trunkSizeId = 0;
int _campaignId = 0;
String _remark = '';
double _latitude = 0.0;
double _longitude = 0.0;
DateTime _insertTime = DateTime.now();



  MarkedTreeDB()
  {
    tableName = 'markedTree';
  }

  int get speciesId => _speciesId;
int get trunkSizeId => _trunkSizeId;
int get campaignId => _campaignId;
String get remark => _remark;
double get latitude => _latitude;
double get longitude => _longitude;
DateTime get insertTime => _insertTime;



  
                    set speciesId(int value)
                    {
                        if (_speciesId != value)
                        {
                        dataUpdated(); 
                        _speciesId = value;
                        }
                    }
                
                    set trunkSizeId(int value)
                    {
                        if (_trunkSizeId != value)
                        {
                        dataUpdated(); 
                        _trunkSizeId = value;
                        }
                    }
                
                    set campaignId(int value)
                    {
                        if (_campaignId != value)
                        {
                        dataUpdated(); 
                        _campaignId = value;
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
    //Map<String, Object?> result = super.toMap();
   return{
      'speciesId': _speciesId,
'trunkSizeId': _trunkSizeId,
'campaignId': _campaignId,
'remark': _remark,
'latitude': _latitude,
'longitude': _longitude,
'insertTime': _insertTime.millisecondsSinceEpoch,

    };
    
  }


  MarkedTree fromMap(Map<String,Object?> map)
  {
    MarkedTree result = MarkedTree(this) ;
    super.id = map["id"] as int; 
    
    _speciesId = map['speciesId'] as int;
_trunkSizeId = map['trunkSizeId'] as int;
_campaignId = map['campaignId'] as int;
_remark = map['remark'] as String;
_latitude = map['latitude'] as double;
_longitude = map['longitude'] as double;
_insertTime = DateTime.fromMillisecondsSinceEpoch(map['insertTime'] as int);



    return result; 

  }



}