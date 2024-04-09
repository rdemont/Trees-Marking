import '../../businessObj/species.dart';
import '../businessObj/speciesGen.dart';
import '../../databaseObj/databaseObj.dart';


class SpeciesDBGen extends DatabaseObj {
  
  String _name = '';
  String _code = '';
  int _type = 0;
  bool _communUse = true;



  SpeciesDBGen()
  {
    tableName = 'species';
  }

  String get name => _name;
  String get code => _code;
  int get type => _type;
  bool get communUse => _communUse;



  set name(String value)
  {
    if (_name != value)
    {
      dataUpdated(); 
      _name = value;
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
  set type(int value)
  {
    if (_type != value)
    {
      dataUpdated(); 
      _type = value;
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
    return query(SpeciesGen.TABLE_NAME,where: SpeciesGen.COLUMN_ID+" = $id").then((obj)
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
      SpeciesGen.COLUMN_CODE : _code,
      SpeciesGen.COLUMN_TYPE : _type,
      SpeciesGen.COLUMN_COMMUNUSE : _communUse,

    };
    
  }


  Future<Species> fromMap(Map<String,Object?> map)
  async {
    Species result = Species(this) ;
    super.id = map[SpeciesGen.COLUMN_ID] as int; 
    
    _name = (map[SpeciesGen.COLUMN_NAME]??'') as String;
    _code = (map[SpeciesGen.COLUMN_CODE]??'') as String;
    _type = (map[SpeciesGen.COLUMN_TYPE]??0) as int;
    _communUse = ((map[SpeciesGen.COLUMN_COMMUNUSE]??0) as int) == 1;



    return result; 

  }



}