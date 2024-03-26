

import '../businessObj/species.dart';
import 'databaseObj.dart';

class SpeciesDB extends DatabaseObj {
  


  String _name = '';
String _communUse = '';



  SpeciesDB()
  {
    tableName = 'species';
  }

  String get name => _name;
String get communUse => _communUse;



  
                    set name(String value)
                    {
                        if (_name != value)
                        {
                        dataUpdated(); 
                        _name = value;
                        }
                    }
                
                    set communUse(String value)
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
        fromMap(obj[0]);
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
    //Map<String, Object?> result = super.toMap();
   return{
      'name': _name,
'communUse': _communUse,

    };
    
  }


  Species fromMap(Map<String,Object?> map)
  {
    Species result = Species(this) ;
    super.id = map["id"] as int; 
    
    _name = map['name'] as String;
_communUse = map['communUse'] as String;



    return result; 

  }



}