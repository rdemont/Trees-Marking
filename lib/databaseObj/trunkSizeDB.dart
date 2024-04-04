

import '../businessObj/trunkSize.dart';

import 'databaseObj.dart';

class TrunkSizeDB extends DatabaseObj {
  


  double _minDiameter = 0.0;
double _maxDiameter = 0.0;
double _volume = 0.0;
String _code = '';
String _name = '';



  TrunkSizeDB()
  {
    tableName = 'trunkSize';
  }

  double get minDiameter => _minDiameter;
double get maxDiameter => _maxDiameter;
double get volume => _volume;
String get code => _code;
String get name => _name;



  
                    set minDiameter(double value)
                    {
                        if (_minDiameter != value)
                        {
                        dataUpdated(); 
                        _minDiameter = value;
                        }
                    }
                
                    set maxDiameter(double value)
                    {
                        if (_maxDiameter != value)
                        {
                        dataUpdated(); 
                        _maxDiameter = value;
                        }
                    }
                
                    set volume(double value)
                    {
                        if (_volume != value)
                        {
                        dataUpdated(); 
                        _volume = value;
                        }
                    }
                
                    set code(String value)
                    {
                        if (_code != value)
                        {
                        dataUpdated(); 
                        _code = value;
                        }
                    }
                
                    set name(String value)
                    {
                        if (_name != value)
                        {
                        dataUpdated(); 
                        _name = value;
                        }
                    }
                

  Future<TrunkSize> open(int id)
  {
    return query(tableName,where: "id = $id").then((obj){
      TrunkSize result = TrunkSize(this);
      if (!obj.isEmpty)
      {
        fromMap(obj[0]);
      }
      return result ; 
    });
  }

  TrunkSize newObj()
  {
    TrunkSize result = TrunkSize(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    //Map<String, Object?> result = super.toMap();
   return{
      'minDiameter': _minDiameter,
'maxDiameter': _maxDiameter,
'volume': _volume,
'code': _code,
'name': _name,

    };
    
  }


  TrunkSize fromMap(Map<String,Object?> map)
  {
    TrunkSize result = TrunkSize(this) ;
    super.id = map["id"] as int; 
    
    _minDiameter = (map['minDiameter']??0.0) as double;
_maxDiameter = (map['maxDiameter']??0.0) as double;
_volume = (map['volume']??0.0) as double;
_code = (map['code']??'') as String;
_name = (map['name']??'') as String;



    return result; 

  }



}