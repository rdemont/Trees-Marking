import '../businessObj/species.dart';
import 'databaseObj.dart';

class SpeciesDB extends DatabaseObj {
  


  String _name ='' ;
  bool _communUse = false;

  SpeciesDB()
  {
    tableName = 'species';
  }

  String get name => _name;
  bool get communUse => _communUse;


  set name(String value)
  {
    if (_name != value)
    {
      dataUpdated(); 
      _name = value;
    }
  }

  set communUse(bool value)
  {
    if (_communUse != value)
    {
      dataUpdated(); 
      _communUse = value;
    }
  }


  Future<Species> open(int id)
  {
    return query(tableName,where: "id = $id").then((obj){
      Species result = Species(this);
      if (obj.isEmpty)
      {
        
      }else {
        id = obj[0]["id"] as int; 
        _name = obj[0]["name"] as String; 
        _communUse = ((obj[0]["communUse"] as int) == 0 ? true: false) ; 
      }
      return result ; 
    });
  }

  Species newObj()
  {
    Species result = Species(this);
    return result ; 
  }


  @override
  Map<String, Object?> toMap() 
  {
    Map<String, Object?> result = super.toMap();
    result.addAll({
      'name':_name,
      'communuse': _communUse ? 0 : 1 
    });
    return  result ; 
  }

}