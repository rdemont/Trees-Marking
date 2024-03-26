

import '../businessObj/trunkSize.dart';
import 'databaseObj.dart';

class TrunkSizeDB extends DatabaseObj {
  


  int _minDiameter = 0;
int _maxDiameter = 0;
String _name = '';



  TrunkSizeDB()
  {
    tableName = 'trunkSize';
  }

  int get minDiameter => _minDiameter;
int get maxDiameter => _maxDiameter;
String get name => _name;



  
                    set minDiameter(int value)
                    {
                        if (_minDiameter != value)
                        {
                        dataUpdated(); 
                        _minDiameter = value;
                        }
                    }
                
                    set maxDiameter(int value)
                    {
                        if (_maxDiameter != value)
                        {
                        dataUpdated(); 
                        _maxDiameter = value;
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
      if (obj.isEmpty)
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
'name': _name,

    };
    
  }


  TrunkSize fromMap(Map<String,Object?> map)
  {
    TrunkSize result = TrunkSize(this) ;
    super.id = map["id"] as int; 
    
    _minDiameter = map['minDiameter'] as int;
_maxDiameter = map['maxDiameter'] as int;
_name = map['name'] as String;



    return result; 

  }



}