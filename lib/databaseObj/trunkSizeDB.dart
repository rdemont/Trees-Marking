



import '../businessObj/trunkSize.dart';
import 'databaseObj.dart';

class TrunkSizeDB extends DatabaseObj {
  


  String _name ='' ;
  int _minDiameter = 0;
  int _maxDiameter = 0;

  SpeciesDB()
  {
    tableName = 'trunkSize';
  }

  String get name => _name;
  int get minDiameter => _minDiameter;
  int get maxDiameter => _maxDiameter;



  set name(String value)
  {
    if (_name != value)
    {
      dataUpdated(); 
      _name = value;
    }
  }

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


  Future<TrunkSize> open(int id)
  {
    return query(tableName,where: "id = $id").then((obj){
      TrunkSize result = TrunkSize(this);
      if (obj.isEmpty)
      {
        
      }else {
        id = obj[0]["id"] as int; 
        _name = obj[0]["name"] as String; 
        _minDiameter = obj[0]["minDiameter"] as int; 
        _maxDiameter = obj[0]["maxDiameter"] as int; 
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
    return{
      'name':_name,
      'minDiameter': _minDiameter ,
      'maxDiameter': _maxDiameter 
    };
    
  }

}