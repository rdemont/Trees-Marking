import '../../businessObj/species.dart';
import '../businessObj/speciesGen.dart';
import '../../databaseObj/databaseObj.dart';


class SpeciesDBGen extends DatabaseObj {
  
  String _name = '';
  bool _communUse = true;



  SpeciesDBGen()
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
    return query(tableName,where: "id = $id").then((obj)
    {
      Species result = Species(this);
      if (!obj.isEmpty)
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
    return{
      SpeciesGen.COLUMN_NAME : _name,
      SpeciesGen.COLUMN_COMMUNUSE : _communUse,

    };
    
  }


  Future<Species> fromMap(Map<String,Object?> map)
  async {
    Species result = Species(this) ;
    super.id = map["id"] as int; 
    
    _name = (map[SpeciesGen.COLUMN_NAME]??'') as String;
    _communUse = ((map[SpeciesGen.COLUMN_COMMUNUSE]??0) as int) == 1;



    return result; 

  }



}